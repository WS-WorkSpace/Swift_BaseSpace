//
//  CollectListViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/5.
//

import UIKit

class CollectListViewController: DemoTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "示例1.0"
        configTableView()
    }

    private lazy var classArr: NSMutableArray = {
        var dataArr = NSMutableArray()
        dataArr = ["EasyCollectionViewController",
                   "NineGridViewController",
                   "SessionBackImageSectionViewController",
                   "WaterflowCollectionViewController",
                   "NetworkDemoListVC",
                   "LibDemoListVC"]
        return dataArr
    }()

    private func configTableView() {
        modelArr = ["基本使用",
                    "九宫格",
                    "自定义section背景图",
                    "刷新瀑布流",
                    "网络请求",
                    "三方库使用"]

        clickCellBlock = { [weak self] indexPath, _ in
            // OC对象 和 Swift 区别
            let className = self?.classArr.object(at: indexPath.row) as! String
            let jumpVC = NSString.RD_VC_ClassFromString(className)
            jumpVC?.title = self?.modelArr[indexPath.row]
            self?.navigationController?.pushViewController(jumpVC!, animated: true)
        }
    }
}
