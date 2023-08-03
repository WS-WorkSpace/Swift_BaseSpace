//
//  DemoListViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/3.
//

import UIKit

class DemoListViewController: DemoTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "示例1.0"
        configTableView()
    }

    private lazy var classArr: NSMutableArray = {
        var dataArr = NSMutableArray()
        dataArr = ["ExampleUI_ViewController",
                   "AlertUIViewController",
                   "TableViewDemoListVC",
                   "CollectionViewDemoListVC",
                   "NetworkDemoListVC",
                   "LibDemoListVC"]
        return dataArr
    }()

    private func configTableView() {
        modelArr = ["基本控件",
                    "Alert底部弹框",
                    "UITableView",
                    "UICollcetionView",
                    "网络请求",
                    "三方库使用"]

        clickCellBlock = { [weak self] indexPath, _ in
            // OC对象 和 Swift 区别
            let className = self?.classArr.object(at: indexPath.row) as! String
            let jumpVC = NSString.RD_classFromString(className)
            jumpVC?.title = self?.modelArr[indexPath.row]
            self?.navigationController?.pushViewController(jumpVC!, animated: true)
        }
    }
}