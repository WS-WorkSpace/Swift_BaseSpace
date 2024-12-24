//
//  BaseCollectionViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/4.
//

import UIKit

private let CellID = "collectionViewCell"
private let HeaderViewID = "HeaderViewID"
private let FooterViewID = "FooterViewID"

class BaseCollectionViewController: BaseViewController {
    lazy var mFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        //flowLayout.itemSize = CGSizeMake(300, 300)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    lazy var mCollectionView: UICollectionView = {
        let collectionView = BaseCollectionView(frame: .zero, collectionViewLayout: mFlowLayout)
        collectionView.frame = kScrollViewFrame
        collectionView.backgroundColor = BaseBgColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        /*
         // 这句话的意思是为了 不管集合视图里面的值 多不多  都可以滚动 解决了值少了 集合视图不能滚动的问题
         collectionView.alwaysBounceVertical = true
         // 设置上左下右距离
         collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         */
        // header注册
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewID)
        // footer注册
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterViewID)
        return collectionView
    }()

    /// 自定义Cell Block
    var customCellBlock: ((_ indexPath: IndexPath, _ mCustumCell: Any) -> ())?
    /// 点击Cell Block
    var clickCustomCellBlock: ((_ indexPath: IndexPath) -> ())?
    /// 头部 Block
    var customHeaderViewBlock: ((_ indexPath: IndexPath, _ mHeaderView: UIView) -> ())?
    /// 尾部 Block
    var customFooterViewBlock: ((_ indexPath: IndexPath, _ mFooterView: UIView) -> ())?

    /// FlowLayout
    var collectionFlowLayout: UICollectionViewFlowLayout? {
        didSet {
            mCollectionView.collectionViewLayout = collectionFlowLayout ?? UICollectionViewFlowLayout()
        }
    }

    private lazy var dataArr: NSMutableArray = {
        var tempArr = NSMutableArray()
        return tempArr
    }()

    /// 数据源
    var modelArr: NSMutableArray {
        get {
            return dataArr
        }
        set(newValue) {
            dataArr = newValue
        }
    }

    /// 纯代码注册Cell
    func registerCellWhihClassName(className: String) {
        let strTemp = className
        mCollectionView.register(NSString.RD_classFromString(strTemp), forCellWithReuseIdentifier: CellID)
    }

    /// nib方式注册Cell
    func registerCellWithNib(nibString: String) {
        mCollectionView.register(UINib(nibName: nibString, bundle: nil), forCellWithReuseIdentifier: CellID)
    }

    /*
     func registerSupplementaryView(kind: String = UICollectionView.elementKindSectionHeader, viewID: String) {
         mCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewID)
     }
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        configIOS11()
        configIOS15()

        // 设置 CollectionView()之前应先设置 cellName,否则默认为 BaseCollectionViewCell
        // 注册可重用的单元格
        registerCellWhihClassName(className: "BaseCollectionViewCell")
        view.addSubview(mCollectionView)
        // mock 数据
        modelArr = [1, 2, 3, 4, 5, 6, 7]
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        Lg.log(type(of: self))
    }
}

extension BaseCollectionViewController: UICollectionViewDataSource {
    /// @optional section的数量
    /// -Section num  返回分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    /// @required
    /// -返回每个Section下单元格个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }

    /// -cell 对于某个位置应该显示什么样的cell,返回每个单元格视图
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath)
        customCellBlock?(indexPath, cell)
        return cell
    }

    /// - 设置sectionHeader | sectionFooter
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 设置头部
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewID, for: indexPath)
            view.backgroundColor = .red
            customHeaderViewBlock?(indexPath, view)
            return view
        } else if kind == UICollectionView.elementKindSectionFooter {
            // 设置尾部
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterViewID, for: indexPath)
            view.backgroundColor = .yellow
            customFooterViewBlock?(indexPath, view)
            return view
        } else {
            return UICollectionReusableView()
        }
    }
}

extension BaseCollectionViewController: UICollectionViewDelegate {
    /// 是否允许选择某个单元格
    /**
     func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return false
     }
     */

    ///  - 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionView.cellForItem(at: indexPath)
        clickCustomCellBlock?(indexPath)
    }

    /// (@"取消选择----->%zd",indexPath.item)
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        Lg.log("取消选择-----", indexPath.item)
    }

    /** 对应的高亮和选中状态分别由highlighted和selected两个属性表示
     // (@"shouldHighlightItemAtIndexPath 设置是否要高亮"); //    return YES;
      func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {}

     // (@"didHighlightItemAtIndexPath 已经展示高亮");
      func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {}

     // @"didUnhighlightItemAtIndexPath 高亮结束"
      func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {}

     // shouldSelectItemAt 反
      func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {}
     */

    /** 下面三个方法设置cell的menu 弹框
    // 设置是否展示长按菜单
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    // 这个方法用于设置要展示的菜单选项
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool{
        if String(describing: action) == "copy:" || String(describing: action) == "paste:" {
            return true
        }
        return false
        // return action == #selector(copy(_:))

    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            // 获取要复制的内容
            let cell = collectionView.cellForItem(at: indexPath)
            // 显示菜单
            UIMenuController.shared.showMenu(from: cell!, rect: cell!.frame)
            UIMenuController.shared.setMenuVisible(true, animated: true)
        }
    }
    */

}

extension BaseCollectionViewController: UICollectionViewDelegateFlowLayout {
    /// 对某个cell制定尺寸
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.item == 1 {
//            return CGSizeMake(150, 150)
//        }
//        return CGSizeMake(100, 100)
//    }
    
    

    // 返回每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        return numberOfItems > 0 ? UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) :
            UIEdgeInsets.zero
    }

    /*
     collectionView在设置referenceSizeForHeaderInSection(区头视图大小)或者referenceSizeForFooterInSection(区尾视图大小时) 需要区分滚动方向 根据滚动方向不同，header和footer的width和height中只有一个会起作用：
     如果滚动方向是UICollectionViewScrollDirectionHorizontal的话 头视图高度是第一个参数(width)生效
     如果滚动方向是UICollectionViewScrollDirectionVertical的话 头视图高度是第二个参数(height)生效
     */
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        if(section == 1){
//            return CGSizeMake(150, 150);
//        }
//        return CGSizeMake(100, 100);
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        if(section == 1){
//            return CGSizeMake(150, 150);
//        }
//        return CGSizeMake(100, 100);
//    }
}
