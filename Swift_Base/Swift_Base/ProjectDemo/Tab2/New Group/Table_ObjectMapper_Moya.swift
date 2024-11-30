//
//  Table_ObjectMapper_Moya.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/14.
//

import UIKit
import Alamofire
import HandyJSON

class Table_ObjectMapper_Moya: BaseTableViewController {
    lazy var items = [HandyJsonModel]()

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
        /// 添加下来刷新
        subTableView.mAddHeadRefresh(isAutoRefresh: true) { [weak self] in
            guard let self = self else { return }
            /// 开始刷新了
            self.loadNewData(false) {
                /// 停止刷新
                self.subTableView.cr.endHeaderRefresh()
            }
        }
        /// 添加上拉加载更多
        subTableView.addFootRefresh {[weak self] in
            guard let self = self else { return }
            self.loadNewData(true) {
                /// 停止刷新
                self.subTableView.cr.endHeaderRefresh()
            }
        }
        self.view.addSubview(self.subTableView)
        clickCellBlock = { [weak self] _, _ in
            mLog("点击Cell",self as Any)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "Table_HandyJSON_VC"
        self.mConfigTableView()
    }
}

extension Table_ObjectMapper_Moya {
    private func loadNewData(_ isLoadMore:Bool, _ complete:@escaping ()->Void) {
        // 链式网络请求：Alamofire + SwiftyJSON
        let url = "http://rap2api.taobao.org/app/mock/303994/test/dbbooklist"
        FPNetWorkRequest.url(url).requestType(.get).params(nil).requestEasy {[weak self] res in
            let dic = res as? Dictionary<String, Any>
            /// HandyJSON接受字典
            /// 会重新计算label的高度,并保存.刷新UI时,动态改变Cell的高度.此时label 的约束失效.
            guard let resObj = TotalModel.deserialize(from: dic) ,let self = self else { return }
            if !isLoadMore{
                self.items.removeAll()
                self.items = resObj.list
            }else{
                self.items += resObj.list
            }
            mLog(self.items,self.items.count)
            self.subTableView.reloadData()
            complete()
        }
    }
}

extension Table_ObjectMapper_Moya {
    /// 重写父类代理自定义xib cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIBExampleCell.CellID, for: indexPath) as? XIBExampleCell
        let repTestDetail:HandyJsonModel = items[indexPath.row]
        cell?.leftLab.text = repTestDetail.desc
        let imgeURL = "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666"
        cell?.rightImg.kf.setImage(with: URL(string: imgeURL), placeholder: UIImage(named: "AppIcon-mini"), options: nil, progressBlock: nil, completionHandler: nil)
        cell?.backgroundColor = UIColor.randomColor
        cell?.leftLab.numberOfLines = 0
        return cell ?? XIBExampleCell()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.jsonModel?.count ?? 0
        return  items.count

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.row].cellHeight
    }
}
