//
//  BaseViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/1.
//

import UIKit

class BaseViewController: UIViewController {
    /// 标题
    var navTitle: String? {
        didSet {
            navigationItem.title = navTitle
        }
    }

    /// 导航栏左侧标题
    var navLeftTitle: String? {
        didSet {
            let item = UIBarButtonItem.RD_textItem(title: navLeftTitle ?? "", titleColor: BaseNavTextColor, target: self, action: #selector(ClickLeftItem))
            navigationItem.leftBarButtonItem = item
        }
    }

    /// 导航栏左侧img
    var navLeftImage: (String, String)? {
        didSet {
            let item = UIBarButtonItem.RD_imageItem(imageName: navLeftImage ?? ("", ""), target: self, action: #selector(ClickLeftItem))
            navigationItem.leftBarButtonItem = item
        }
    }

    /// 导航栏右侧标题
    var navRightTitle: String? {
        didSet {
            let item = UIBarButtonItem.RD_textItem(title: navRightTitle ?? "", titleColor: BaseNavTextColor, target: self, action: #selector(ClickRightItem))
            navigationItem.rightBarButtonItem = item
        }
    }

    /// 导航栏右侧img
    var navRightImage: (String, String)? {
        didSet {
            let item = UIBarButtonItem.RD_imageItem(imageName: navRightImage ?? ("", ""), target: self, action: #selector(ClickRightItem))
            navigationItem.rightBarButtonItem = item
        }
    }

    /// 点击导航栏左侧item Block
    var ClickNavLeftItemBlock: (() -> Void)?
    /// 点击导航栏右侧item Block
    var ClickNavRightItemBlock: (() -> Void)?
    /// 点击视图的回调
    var ClickKeyboard: (() -> Void)?

    @objc func ClickLeftItem() {
        ClickNavLeftItemBlock?()
    }

    @objc func ClickRightItem() {
        ClickNavRightItemBlock?()
    }

    // MARK: - VC circle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.hexColor(0xF2F4F7)
//        edgesForExtendedLayout = UIRectEdge.bottom
//        if responds(to: Selector(("edgesForExtendedLayout"))) {
//            edgesForExtendedLayout = UIRectEdge(rawValue: 0)
//        }

        /// 适配
//        ConfigVersion.configIOS11(self)
//        ConfigVersion.configIOS15()
        configIOS11()
        configIOS15()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        Lg.log(type(of: self))
    }

    // MARK: - 隐藏键盘

    func hideKeyboardWhenTapedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
        ClickKeyboard?()
    }
}

extension BaseViewController {
    // MARK: - iOS 适配

    func configIOS11() {
        /// 适配 iOS 11.0 ,iOS11以后，控制器的automaticallyAdjustsScrollViewInsets已经废弃，所以默认就会是YES
        /// iOS 11新增：adjustContentInset 和 contentInsetAdjustmentBehavior 来处理滚动区域
        if #available(iOS 11.0, *) {
            UITableView.appearance().estimatedRowHeight = 0
            UITableView.appearance().estimatedSectionHeaderHeight = 0
            UITableView.appearance().estimatedSectionFooterHeight = 0
            // 防止列表/页面偏移
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
            UITableView.appearance().contentInsetAdjustmentBehavior = .never
            UICollectionView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }

    func configIOS15() {
        // 适配iOS15，tableView的section设置
        // iOS15中，tableView会给每一个section的顶部（header以上）再加上一个22像素的高度，形成一个section和section之间的间距
        // 新增的sectionHeaderTopPadding会使表头新增一段间隙，默认为UITableViewAutomaticDimension
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
}
