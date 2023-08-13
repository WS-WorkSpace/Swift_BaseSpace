//
//  TableListViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/11.
//

import UIKit

class TableListViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "TableViw示例1.0"
        self.mConfigTableView()
    }

    private lazy var classArr: NSMutableArray = {
        var dataArr = NSMutableArray()
        dataArr = ["TableXIBViewController",
                   "Table_SwiftyJSON_VC",
                   "SessionBackImageSectionViewController",
                   "WaterflowCollectionViewController",
                   "NetworkDemoListVC"]
        return dataArr
    }()

    lazy var subTableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero)
        tableView.frame = kScrollViewFrame
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.RD_registerCell(UITableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .yellow
        return tableView
    }()

    private func mConfigTableView() {
        self.view.addSubview(self.subTableView)
        configModelArr = ["XIB + TableView",
                          "链式 + TableView + SwiftyJSON",
                          "自定义section背景图",
                          "刷新瀑布流",
                          "网络请求"]
//        self.tableView.showEmptyDataViewWithType(EmptyDataViewState.StateNetWorkError)

        clickCellBlock = { [weak self] indexPath, _ in
            // OC对象 和 Swift 区别
            let className = self?.classArr.object(at: indexPath.row) as! String
            let jumpVC = NSString.RD_VC_ClassFromString(className)
            jumpVC?.title = self?.configModelArr[indexPath.row]
            self?.navigationController?.pushViewController(jumpVC!, animated: true)
        }
    }
}
