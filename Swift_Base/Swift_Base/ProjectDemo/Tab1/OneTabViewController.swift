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
        configModelArr = ["1", "2", "3", "4", "5", "6", "7", "8"]
        let item1 = UIBarButtonItem.RD_imageItem(imageName: navRightImage ?? ("tab5", "tab5_select"), target: self, action: #selector(self.demoListVC))
        let item2 = UIBarButtonItem.RD_textItem(title: "FPS", titleColor: .black, target: self, action: #selector(self.addFPSLable))
        navigationItem.rightBarButtonItems = [item1, item2]

        let header = SelfRefreshGifHeader(refreshingBlock: self.loadNewData)
        header.beginRefreshing()
        tableView.mj_header = header

        tableView.mj_footer = SelfRefreshBackGifFooter(refreshingBlock: self.loadMoreData)
    }

    @objc func demoListVC() {
        self.navigationController?.pushViewController(DemoListViewController(), animated: true)
    }

    @objc func addFPSLable() {}

    func loadNewData() {
        sleep(1)
        self.tableView.mj_header?.endRefreshing()
    }

    func loadMoreData() {
        sleep(1)
        self.tableView.mj_footer?.endRefreshing()
    }
}
