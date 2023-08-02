//
//  OneTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class OneTabViewController: DemoTableViewController {
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        modelArr = ["1","2","3","4","5","6","7"]
        navRightImage = ("Alert_info", "Alert_success")
        self.ClickNavRightItemBlock = { [weak self] in
            self?.navigationController?.pushViewController(DemoListViewController(), animated: true)
        }

        let header = SelfRefreshGifHeader(refreshingBlock: self.loadNewData)
        header.beginRefreshing()
        tableView.mj_header = header
        
        tableView.mj_footer = SelfRefreshBackGifFooter(refreshingBlock: self.loadMoreData)

    }
    func loadNewData() -> Void {
        sleep(1)
        self.tableView.mj_header?.endRefreshing()

    }
    func loadMoreData() -> Void {
        sleep(1)
        self.tableView.mj_footer?.endRefreshing()
    }
}


