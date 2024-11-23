//
//  TwoTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class TwoTabViewController: BaseTableViewController {
    var page = 1

    private lazy var vcArray: [String] = {
        let _vcArray = ["SwiftyJSONViewController",
                        "",
                        "",
                        "",
                        "Table_SwiftyJSON_VC",
                        "Table_HandyJSON_VC",
                        "Table_ObjectMapper_Moya",
                        ""]
        return _vcArray
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        view.backgroundColor = .white
        // 计算属性,设置cell.textLabel
        configModelArr = ["SwiftyJSON使用",
                          "",
                          "",
                          "",
                          "链式+SwiftyJSON",
                          "链式+HandyJSON",
                          "Table_ObjectMapper_Moya",
                          ""]

        // MARK: - BarIetms设置

        let item1 = UIBarButtonItem.RD_imageItem(imageName: navRightImage ?? ("tab5", "tab5_select"), target: self, action: #selector(self.demoListVC))
        let item2 = UIBarButtonItem.RD_textItem(title: "NetWoring", titleColor: .black, target: self, action: #selector(self.netWoringMethod))
        navigationItem.rightBarButtonItems = [item1, item2]

        // MARK: - 下拉,上拉刷新设置

        let header = SelfRefreshGifHeader(refreshingBlock: self.loadNewData)
        header.beginRefreshing()
        mTableView.mj_header = header
        mTableView.mj_footer = SelfRefreshBackGifFooter(refreshingBlock: self.loadMoreData)

        // MARK: - 点击cell的closure返回

        self.clickCellBlock = { (index: IndexPath, _: String) in
            let vc = NSString.RD_VC_ClassFromString(self.vcArray[index.row])
            if let _vc = vc {
                self.navigationController?.pushViewController(_vc, animated: true)
            }
        }
    }

    // MARK: - BarIetms方法

    @objc func netWoringMethod() {
        self.navigationController?.pushViewController(NetWorkingListViewController(), animated: true)
    }

    @objc func demoListVC() {
        Toast.toast("这里未定义")
    }

    // MARK: - 下拉,上拉刷新方法

    func loadNewData() {
        sleep(1)
        self.mTableView.mj_header?.endRefreshing()
    }

    func loadMoreData() {
        sleep(1)
        self.mTableView.mj_footer?.endRefreshing()
    }
}
