//
//  Table_MJExtension_VC.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/14.
//

import UIKit

class Table_MJExtension_VC: BaseTableViewController {

    lazy var subTableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero)
        tableView.frame = kScrollViewFrame
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "XIBExampleCell", bundle: nil), forCellReuseIdentifier: XIBExampleCell.CellID)
//        tableView.RD_registerNibCell(XIBExampleCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .yellow
        return tableView
    }()

    private func mConfigTableView() {
        self.view.addSubview(self.subTableView)
        clickCellBlock = { [weak self] _, _ in
            // OC对象 和 Swift 区别
            let mType: UIViewController.Type = Table_SwiftyJSON_VC.self
            let childVC = mType.init()
            self?.navigationController?.pushViewController(childVC, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "Table_MJExtension_VC"
        self.mConfigTableView()
        self.loadNewData()
    }
}

extension Table_MJExtension_VC {
    private func loadNewData() {
        // 链式网络请求：Alamofire + SwiftyJSON
        let url = "http://rap2api.taobao.org/app/mock/303994/test/dbbooklist"
        CP_Net_Request.url(url).requestType(.get).params(nil).success { res in
            mLog(res)
            self.subTableView.reloadData()
        }.failure { errorCode, msg in
            mLog(errorCode ?? -999)
            mLog(msg)
        }.request()
    }
}

extension Table_MJExtension_VC {
    /// 重写父类代理自定义xib cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIBExampleCell.CellID, for: indexPath) as? XIBExampleCell
//        guard let mJsonModel = jsonModel else { return cell ?? XIBExampleCell() }
//        let arrTemp = mJsonModel["data"]
//        let cityStr = arrTemp[indexPath.row]["city"]
//        cell?.leftLab.text = arrTemp[indexPath.row]["province"].stringValue + ":\n" + cityStr.stringValue
//        cell?.rightImg.isHidden = true
//        cell?.backgroundColor = UIColor.randomColor
        return cell ?? XIBExampleCell()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.jsonModel?.count ?? 0
        return  0

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
