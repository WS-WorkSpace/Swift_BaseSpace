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
    /// 自定义的CellName
    var registerCell: String? {
        didSet {
            let strTemp = registerCell ?? "BaseCollectionViewCell"
            collectionView.register(NSString.RD_classFromString(strTemp), forCellWithReuseIdentifier: CellID)
//             collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: CellID)
        }
    }

    var registerCellWithNib: String? {
        didSet {
            // Nib注册Cell
            collectionView.register(UINib(nibName: registerCellWithNib ?? "BaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CellID)
        }
    }

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()

        let collectionView = BaseCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.frame = kScrollViewFrame
        collectionView.backgroundColor = BaseBgColor
        collectionView.delegate = self
        collectionView.dataSource = self
        //        // 这句话的意思是为了 不管集合视图里面的值 多不多  都可以滚动 解决了值少了 集合视图不能滚动的问题
        //        collectionView.alwaysBounceVertical = true
        //        // 设置上左下右距离
        //        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0,right: 0)

        // header注册
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewID)
        // footer注册
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterViewID)
        return collectionView
    }()

    /// 自定义Cell Block
    var custumCellBlock: ((_ indexPath: IndexPath, _ mCustumCell: Any) -> ())?
    /// 点击Cell Block
    var clickCustumCellBlock: ((_ indexPath: IndexPath) -> ())?
    /// 头部 Block
    var custumHeaderViewBlock: ((_ indexPath: IndexPath, _ mHeaderView: UIView) -> ())?
    /// 尾部 Block
    var custumFooterViewBlock: ((_ indexPath: IndexPath, _ mFooterView: UIView) -> ())?

    /// FlowLayout
    var collectionFlowLayout: UICollectionViewFlowLayout? {
        didSet {
            collectionView.collectionViewLayout = collectionFlowLayout ?? UICollectionViewFlowLayout()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        modelArr = [1, 2, 3, 4, 5, 6, 7]
    }

    private func configCollectionView() {
        // 设置 CollectionView()之前应先设置 cellName,否则默认为 BaseCollectionViewCell
        registerCell = "BaseCollectionViewCell"
        view.addSubview(collectionView)
    }
}

extension BaseCollectionViewController: UICollectionViewDataSource {
    /// -Section num
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    /// -每Section多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }

    /// -cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath)
        custumCellBlock?(indexPath, cell)
        return cell
    }

    /// - 设置sectionHeader | sectionFooter
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 设置头部
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewID, for: indexPath)
            view.backgroundColor = .red
            custumHeaderViewBlock?(indexPath, view)
            return view
        } else if kind == UICollectionView.elementKindSectionFooter {
            // 设置尾部
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterViewID, for: indexPath)
            view.backgroundColor = .yellow
            custumFooterViewBlock?(indexPath, view)
            return view
        } else {
            return UICollectionReusableView()
        }
    }
}

extension BaseCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    ///  - 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionView.cellForItem(at: indexPath)
        clickCustumCellBlock?(indexPath)
    }

    /// (@"取消选择----->%zd",indexPath.item)
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        Lg.log("取消选择-----", indexPath.item)
    }

    /// (@"shouldHighlightItemAtIndexPath 设置是否要高亮"); //    return YES;
    // func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {}

    /// (@"didHighlightItemAtIndexPath 已经展示高亮");
    // func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {}

    /// @"didUnhighlightItemAtIndexPath 高亮结束"
    // func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {}

    /// shouldSelectItemAt 反
    // func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {}

    // 长按菜单栏 待续
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    // API_DEPRECATED_WITH_REPLACEMENT("collectionView:contextMenuConfigurationForItemsAtIndexPaths:point:", ios(6.0, 13.0))
    // iOS13 新增
    // override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {}
    // override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {}
}
