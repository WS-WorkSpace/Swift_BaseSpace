//
//  NineGridViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/5.
//

import UIKit

class NineGridViewController: BaseCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
//        modelArr = dataArr
    }
    
    func setupCollectionView() {
        customCellBlock = { [weak self] (indexpath, customCell) in
            let cell = customCell as? BaseCollectionViewCell
            cell?.contentView.backgroundColor = UIColor.randomColor
        }
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .vertical // 方向
//        let margin = 10.0 // 设置间距
//        let maxCol = 3.0 // 设置列数
//        // 设置item尺寸
//        let itemW = (kScreenWidth - (maxCol + 1) * margin - 1) / maxCol
//        let itemH = itemW + 20
//        flowLayout.itemSize = CGSize(width: itemW, height: itemH) // 每个item的大小
//        flowLayout.minimumLineSpacing = margin // 设置最小行间距
//        flowLayout.minimumInteritemSpacing = margin // 最小列间距
//        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin) // 每组的四周位置间距 ,分别为上、左、下、右
//
//        collectionFlowLayout = flowLayout
//        registerCellWithNib = "DemoCollectionViewCell"
//
//        custumCellBlock = { [weak self] indexPath, custumCell in
//            let cell: DemoCollectionViewCell = custumCell as! DemoCollectionViewCell
//
//            // -------------------- SwiftyJSON --------------------
//            let dict = JSON(self?.modelArr as Any)[indexPath.row]
//            //            JhLog("dict : \(dict)")
//            //            JhLog("text : \(dict["text"])")
//            cell.textLabel.text = String(describing: dict["text"])
//            cell.imgView.image = UIImage(named: String(describing: dict["img"]))
//        }
//
//        clickCustumCellBlock = { [weak self] indexPath in
//            let cell = self?.collectionView.cellForItem(at: indexPath) as! DemoCollectionViewCell
//            Lg.log("cell : \(String(describing: cell.textLabel.text))")
//
//            Lg.log("选中section:\(indexPath.section) ")
//            Lg.log("选中row:\(indexPath.row) ")
//
//            let data = JSON(self?.dataArr as Any)[indexPath.row]
//            Lg.log("选中cell : \(data)")
//
//            MBProgressHUD_Alert.show(type: .info, text: "text")
//        }
//
//        // 添加头部
//        let headerHeight = 50.0
//        let headerView = UIView(frame: .zero)
//        headerView.backgroundColor = RD_RandomColor()
//        headerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: headerHeight)
//        collectionFlowLayout?.headerReferenceSize = CGSize(width: kScreenWidth, height: headerHeight)
//        //        Jh_collectionFlowLayout?.sectionHeadersPinToVisibleBounds = true // 悬停
//        custumHeaderViewBlock = { _, mHeaderView in
//            mHeaderView.addSubview(headerView)
//        }
//
//        // 添加尾部
//        let footerHeight = 50.0
//        let footerView = UIView(frame: .zero)
//        footerView.backgroundColor = RD_RandomColor()
//        footerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: footerHeight)
//        collectionFlowLayout?.footerReferenceSize = CGSize(width: kScreenWidth, height: footerHeight)
//        //        Jh_collectionFlowLayout?.sectionFootersPinToVisibleBounds = true // 悬停
//        custumFooterViewBlock = { _, mFooterView in
//            mFooterView.addSubview(footerView)
//        }
    }

}
