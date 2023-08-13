//
//  NetWorkingListViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/10.
//

import UIKit

class NetWorkingListViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "网络类demo示例 1.0"
        mConfigTableView()
    }

    private lazy var classArr: NSMutableArray = {
        var dataArr = NSMutableArray()
        dataArr = ["ExampleUI_ViewController",
                   "AlertUIViewController",
                   "TableViewDemoListVC",
                   "CollectListViewController",
                   "NetworkDemoListVC",
                   "LibDemoListVC"]
        return dataArr
    }()

    private func mConfigTableView() {
        self.configTableView()
        configModelArr = ["基本控件",
                          "Alert底部弹框",
                          "UITableView",
                          "UICollcetionView列表",
                          "网络请求",
                          "三方库使用"]

        clickCellBlock = { [weak self] indexPath, _ in
            // OC对象 和 Swift 区别
            let className = self?.classArr.object(at: indexPath.row) as! String
            let jumpVC = NSString.RD_VC_ClassFromString(className)
            jumpVC?.title = self?.configModelArr[indexPath.row]
            self?.navigationController?.pushViewController(jumpVC!, animated: true)
        }
    }
}
