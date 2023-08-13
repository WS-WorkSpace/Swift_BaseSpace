//
//  Table_MJExtension_VC.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/13.
//

import SwiftyJSON
import UIKit
import Kingfisher

class Table_SwiftyJSON_VC: BaseTableViewController {
    private var jsonModel: JSON?

    lazy var subTableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero)
        tableView.frame = kScrollViewFrame
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        /*
         xib创建的view直接赋值给tableview.tableHeaderView会出现view填充不满的问题，右边会有留白现象。即使用Masoty约束frame也没有效果。
         原因：xib创建的view直接赋值给tableview.tableHeaderView会造成约束问题不准确。
         解决办法：先代码创建一个空的UIview,比如叫bgview同时设置frame,把tableview.tableHeaderView = bgview.然后在把xib创建的view添加到bgview上即可。
         */
//        let boundle = Bundle.main.loadNibNamed("XIBTableHeaderView", owner: nil)
//        let viewT = boundle?.first as? XIBTableHeaderView
//        viewT?.backgroundColor = .lightGray
//        tableView.tableHeaderView = viewT

        lazy var headerView = XIBTableHeaderView.loadFromNib()
        tableView.tableHeaderView = headerView

        tableView.register(UINib(nibName: "XIBExampleCell", bundle: nil), forCellReuseIdentifier: XIBExampleCell.CellID)
//        tableView.RD_registerNibCell(XIBExampleCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .yellow
        return tableView
    }()

    private func mConfigTableView() {
        self.view.addSubview(self.subTableView)
        configModelArr = ["label:a", "label:b,label:label:", "label:clabel:clabel:clabel:clabel:c", "d", "e", "f", "label:label:clabel:clabel:clabel:clabel:clabel:clabel:clabel:clabel:clabel:c"]

//        self.tableView.showEmptyDataViewWithType(EmptyDataViewState.StateNetWorkError)

        clickCellBlock = { [weak self] _, _ in
            // OC对象 和 Swift 区别
            let mType: UIViewController.Type = Table_SwiftyJSON_VC.self
            let childVC = mType.init()
            self?.navigationController?.pushViewController(childVC, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "Table_SwiftyJSON_VC"
        self.mConfigTableView()
        self.loadNewData()
    }
}

extension Table_SwiftyJSON_VC {
    private func loadNewData() {
        // 链式网络请求：Alamofire + SwiftyJSON
        let url = kBaseURL + "/mock/simpleArrDict"
        let mSuccess: (JSON) -> Void = {
            json in
            self.jsonModel = json
            mLog(json)
            self.subTableView.reloadData()
        }
        let mFailure: (Int?, String) -> Void = {
            errorCode, msg in
            mLog(errorCode ?? -999)
            mLog(msg)
        }
        CP_Net.shared.url(url).requestType(.get).params(nil).success(mSuccess).failure(mFailure).request()
//        CP_Net_Request.url(baseUrl).requestType(.get).params(nil).success { res in
//            print(" ========链式网络请求======== ")
//            print(res)
//            print(res["code"])
//            //            let decoder = JSONDecoder()
//            //            let model = try? decoder.decode(DMModel.self, from: jsonData)
//            //            self.model = model
//            //            self.tableView.reloadData()
//        }.failure { code, msg in
//            print("code : \(String(describing: code))")
//            print("message : \(msg)")
//        }.request()
    }
}

extension Table_SwiftyJSON_VC {
    /// 重写父类代理自定义xib cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIBExampleCell.CellID, for: indexPath) as? XIBExampleCell
        guard let mJsonModel = jsonModel else { return cell ?? XIBExampleCell() }
        let arrTemp = mJsonModel["data"]
        let cityStr = arrTemp[indexPath.row]["city"]
        cell?.leftLab.text = arrTemp[indexPath.row]["province"].stringValue + ":\n" + cityStr.stringValue
        cell?.rightImg.kf.setImage(with: URL(string: arrTemp[indexPath.row]["imageUrl"].stringValue), placeholder: UIImage(named: "AppIcon-mini"), options: nil, progressBlock: nil, completionHandler: nil)
        cell?.backgroundColor = UIColor.randomColor
        return cell ?? XIBExampleCell()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonModel?["data"].arrayValue.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
