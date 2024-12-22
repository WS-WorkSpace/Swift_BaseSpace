//
//  TwoTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class TwoTabViewController: BaseTableViewController {
    var page = 1
    private lazy var titleArray: [[String]] = {
        let modelArray = ["SwiftyJSON示例",
                          "HandyJson示例",
                          "ObjectMapper示例",
                          "Codable示例"]
        let netArray = ["Alamofire示例",
                        "Moya示例",
                        "KingFisher示例",
                        "WCDB示例",
                        ""]
        let _vcArray = [modelArray, netArray]
        return _vcArray
    }()

    private lazy var mVCArray: [[String]] = {
        let modelArray = ["SwiftyJSONViewController",
                          "HandyJsonTableViewController",
                          "ObjectMapperViewController",
                          "CodableViewController"]
        let netArray = ["AlamofireViewController",
                        "MoyaViewController",
                        "KingfisherViewController",
                        "WCDBViewController",
                        ""]
        let _vcArray = [modelArray, netArray]
        return _vcArray
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        view.backgroundColor = .white

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

        self.clickCellBlock = { (indexPath: IndexPath, _: String) in
            let vc = NSString.RD_VC_ClassFromString(self.mVCArray[indexPath.section][indexPath.row])
            if let _vc = vc {
                self.navigationController?.pushViewController(_vc, animated: true)
            }
        }
    }

    // MARK: - BarIetms方法

    @objc func netWoringMethod() {
    }

    @objc func demoListVC() {
        Toast.toast("这里未定义")
    }

    // MARK: - 下拉,上拉刷新方法

    func loadNewData() {
//        sleep(1)
        self.mTableView.mj_header?.endRefreshing()
    }

    func loadMoreData() {
        sleep(1)
        self.mTableView.mj_footer?.endRefreshing()
    }
}

extension TwoTabViewController {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "数据模型" : "网络请求"
    }
}

extension TwoTabViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mVCArray[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = self.titleArray[indexPath.section][indexPath.row]
        return cell
    }
}

extension TwoTabViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 取消选中
        let cell = tableView.cellForRow(at: indexPath)
        let text = cell?.textLabel?.text ?? ""
        // Lg.log("- 选中cell : \(text)")
        clickCellBlock?(indexPath, text)
    }
}
