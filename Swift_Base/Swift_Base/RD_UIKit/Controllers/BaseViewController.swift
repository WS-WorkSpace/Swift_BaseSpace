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
        ConfigVersion.configIOS11(self)
        ConfigVersion.configIOS15()
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

extension BaseViewController {}
