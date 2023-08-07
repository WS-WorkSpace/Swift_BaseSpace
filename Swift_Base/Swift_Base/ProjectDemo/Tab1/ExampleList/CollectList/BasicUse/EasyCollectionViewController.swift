//
//  NineGridViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/5.
//

import SwiftyJSON
import UIKit

class EasyCollectionViewController: BaseCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        modelArr = dataArr
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical // 方向
        let margin = 10.0 // 设置间距
        let maxCol = 3.0 // 设置列数
        // 设置item尺寸
        let itemW = (kScreenWidth - (maxCol + 1) * margin - 1) / maxCol
        let itemH = itemW + 20
        flowLayout.itemSize = CGSize(width: itemW, height: itemH) // 每个item的大小
        flowLayout.minimumLineSpacing = margin // 设置最小行间距
        flowLayout.minimumInteritemSpacing = margin // 最小列间距
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin) // 每组的四周位置间距 ,分别为上、左、下、右
        
        collectionFlowLayout = flowLayout
        
        registerCellWithNib = "DemoCollectionViewCell"

        customCellBlock = { [weak self] indexPath, customCell in
            let cell = customCell as? DemoCollectionViewCell
            
            // -------------------- SwiftyJSON --------------------
            let dict = JSON(self?.modelArr as Any)[indexPath.row]
            //            JhLog("dict : \(dict)")
            //            JhLog("text : \(dict["text"])")
            cell?.textLabel.text = String(describing: dict["text"])
            cell?.imgView.image = UIImage(named: String(describing: dict["img"]))
        }
        
        clickCustomCellBlock = { [weak self] indexPath in
            let cell = self?.collectionView.cellForItem(at: indexPath) as! DemoCollectionViewCell
            Lg.log("cell : \(String(describing: cell.textLabel.text))")
            
            Lg.log("选中section:\(indexPath.section) ")
            Lg.log("选中row:\(indexPath.row) ")
            
            let data = JSON(self?.dataArr as Any)[indexPath.row]
            Lg.log("选中cell : \(data)")
        
            MBProgressHUD_Alert.show(type: .info, text: "text")
        }
        
        // 添加头部
        let headerHeight = 50.0
        let headerView = UIView(frame: .zero)
        headerView.backgroundColor = RD_RandomColor()
        headerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: headerHeight)
        collectionFlowLayout?.headerReferenceSize = CGSize(width: kScreenWidth, height: headerHeight)
        collectionFlowLayout?.sectionHeadersPinToVisibleBounds = true // 悬停
        customHeaderViewBlock = { indexpath, mHeaderView in
            print("-----------",indexpath.section)
            mHeaderView.addSubview(headerView)
        }
        
        // 添加尾部
        let footerHeight = 50.0
        let footerView = UIView(frame: .zero)
        footerView.backgroundColor = RD_RandomColor()
        footerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: footerHeight)
        collectionFlowLayout?.footerReferenceSize = CGSize(width: kScreenWidth, height: footerHeight)
        //        Jh_collectionFlowLayout?.sectionFootersPinToVisibleBounds = true // 悬停
        customFooterViewBlock = { _, mFooterView in
            mFooterView.addSubview(footerView)
        }
        
    }
    
    lazy var dataArr: NSMutableArray = {
        var tempArr = NSMutableArray()
        for i in 0 ..< 50 {
            let text = "测试-\(i)"
            var dict = NSMutableDictionary()
            dict["text"] = text
            dict["img"] = "AppIcon-mini"
            tempArr.add(dict)
        }
        dataArr = tempArr
        return dataArr
    }()
}
