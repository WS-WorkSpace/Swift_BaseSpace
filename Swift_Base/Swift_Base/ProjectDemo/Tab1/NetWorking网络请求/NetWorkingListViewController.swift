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
        navTitle = "网络demo示例1.0"
        mConfigTableView()
    }

    private lazy var classArr: NSMutableArray = {
        var dataArr = NSMutableArray()
        dataArr = ["Table_SwiftyJSON_VC",
                   "Table_HandyJSON_VC",
                   "Table_ObjectMapper_Moya",
                   ""]
        return dataArr
    }()

    private func mConfigTableView() {
        configTableView()
        configModelArr = ["链式+SwiftyJSON",
                          "链式+HandyJSON",
                          "Table_ObjectMapper_Moya",
                          ""]

        clickCellBlock = { [weak self] indexPath, _ in
            // OC对象 和 Swift 区别
            let className = self?.classArr.object(at: indexPath.row) as! String
            let jumpVC = NSString.RD_VC_ClassFromString(className)
            jumpVC?.title = self?.configModelArr[indexPath.row]
            self?.navigationController?.pushViewController(jumpVC!, animated: true)
        }
    }
}
