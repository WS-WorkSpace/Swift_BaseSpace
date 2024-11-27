//
//  ESPullToRefreshViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/27.
//

import UIKit


class ESPullToRefreshViewController: UIViewController {
    fileprivate var mDataArray = [JSON]()
    lazy var mTableView: UITableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellID)
        return tabview
    }()

    static let ItemCellID = "ESPullToRefreshCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mTableView)
        getNetModel()
    }

    func getNetModel() {
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]
        DispatchQueue.global().async {
//            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response(completionHandler: { [weak self] response in
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { [weak self] response in
                guard let json = response.result.value, let weakSelf = self else { return }
                let dicJson = JSON(json)
                weakSelf.mDataArray.removeAll()
                weakSelf.mDataArray = dicJson["list"].arrayValue
                weakSelf.mTableView.reloadData()
            })
        }
    }

    deinit {
        print("SwiftyJSONViewController已经释放")
    }
}

extension ESPullToRefreshViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellID, for: indexPath)
        let descString = mDataArray[indexPath.row]["desc"].stringValue
        cell.textLabel?.text = descString
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension ESPullToRefreshViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descString = mDataArray[indexPath.row]["desc"].stringValue
        let contentHeight = descString.RD_getStringHeight(kScreenWidth - 10 - 10, 20)
        let cellHeight = contentHeight + 10 + 10
        return cellHeight
    }
}
