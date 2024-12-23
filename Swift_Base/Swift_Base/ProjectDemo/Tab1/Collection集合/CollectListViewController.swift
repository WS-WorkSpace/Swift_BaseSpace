//
//  CollectListViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/5.
//

import UIKit

class CollectListViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "Collect示例1.0"
        mConfigTableView()
    }

    private lazy var classArr: NSMutableArray = {
        var dataArr = NSMutableArray()
        dataArr = ["BaseCollectionViewController",
                   "EasyCollectionViewController",
                   "NineGridViewController",
                   "SessionBackImageSectionViewController",
                   "WaterflowCollectionViewController"]
        return dataArr
    }()

    private func mConfigTableView() {
        configTableView()
        configModelArr = ["BaseCollection",
                          "基本使用",
                          "九宫格",
                          "自定义section背景图",
                          "刷新瀑布流"]

        clickCellBlock = { [weak self] indexPath, _ in
            // OC对象 和 Swift 区别
            let className = self?.classArr.object(at: indexPath.row) as! String
            let jumpVC = NSString.RD_VC_ClassFromString(className)
            jumpVC?.title = self?.configModelArr[indexPath.row]
            self?.navigationController?.pushViewController(jumpVC!, animated: true)
        }
    }
}
