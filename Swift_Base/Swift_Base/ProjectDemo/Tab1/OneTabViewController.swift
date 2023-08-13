//
//  OneTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class OneTabViewController: BaseTableViewController {
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()

        view.backgroundColor = .white
        configModelArr = ["1", "2", "3", "4", "5", "6", "7", "8"]
        let item1 = UIBarButtonItem.RD_imageItem(imageName: navRightImage ?? ("tab5", "tab5_select"), target: self, action: #selector(self.demoListVC))
        let item2 = UIBarButtonItem.RD_textItem(title: "NetWoring", titleColor: .black, target: self, action: #selector(self.netWoringMethod))
        navigationItem.rightBarButtonItems = [item1, item2]

        let header = SelfRefreshGifHeader(refreshingBlock: self.loadNewData)
        header.beginRefreshing()
        mTableView.mj_header = header

        mTableView.mj_footer = SelfRefreshBackGifFooter(refreshingBlock: self.loadMoreData)
    }

    @objc func netWoringMethod() {
        self.navigationController?.pushViewController(NetWorkingListViewController(), animated: true)
    }

    @objc func demoListVC() {
        self.navigationController?.pushViewController(DemoListViewController(), animated: true)
    }

    func loadNewData() {
        sleep(1)
        self.mTableView.mj_header?.endRefreshing()
    }

    func loadMoreData() {
        sleep(1)
        self.mTableView.mj_footer?.endRefreshing()
    }
}
