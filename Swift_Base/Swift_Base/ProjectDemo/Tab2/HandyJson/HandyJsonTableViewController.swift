//
//  HandyJsonTableViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/24.
//

import HandyJSON
import UIKit

import Alamofire

private struct Book {
    var authorNumber: Int
    var authorName: String
    var desc: String
}

class HandyJsonTableViewController: UIViewController {
    fileprivate var bookArray = [BookModel]()
    lazy var mTableView: UITableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.separatorStyle = .singleLine
        tabview.showsVerticalScrollIndicator = false
        tabview.register(UINib(nibName: "XIBExampleCell", bundle: nil), forCellReuseIdentifier: XIBExampleCell.CellID)
//        tabview.RD_registerNibCell(XIBExampleCell.self)
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        return tabview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mTableView)
        getNetModel()
    }

    deinit {
        print("HandyJsonTableViewController已经释放")
    }

//    func updateModel(_ json: JSON) {
//        let bookArr = json["list"].arrayValue
//        for element in bookArr {
//            let num = element["num"].intValue
//            let name = element["name"].stringValue
//            let desc = element["desc"].stringValue
//            let book = Book(authorNumber: num, authorName: name, desc: desc)
//            bookArray.append(book)
//
    ////            appendModelArr(name) // 列表title
//            mTableView.reloadData()
//        }
//    }

//    private func loadNewData() {
//        // 链式网络请求：Alamofire + SwiftyJSON
//        let url = "http://rap2api.taobao.org/app/mock/303994/test/dbbooklist"
//        CP_Net_Request.url(url).requestType(.get).params(nil).requestEasy {[weak self] res in
//            let dic = res as? Dictionary<String, Any>
//            /// HandyJSON接受字典
//            /// 会重新计算label的高度,并保存.刷新UI时,动态改变Cell的高度.此时label 的约束失效.
//            guard let resObj = TotalModel.deserialize(from: dic) ,let self = self else { return }
//            self.items.removeAll()
//            self.items = resObj.list
//            mLog(self.items)
//            self.subTableView.reloadData()
//        }
//    }

    func getNetModel() {
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]
        DispatchQueue.global().async {
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { [weak self] response in
                if let res = response.result.value {
                    let dic = res as? [String: Any]
                    /// HandyJSON接受字典
                    guard let resObj = BookHandyJsonModel.deserialize(from: dic), let self = self else { return }
                    bookArray.removeAll()
                    bookArray = resObj.list
                    mTableView.reloadData()
                }
            })
        }
    }
}

// MARK: - Table view data source

extension HandyJsonTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return bookArray[indexPath.row].cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: XIBExampleCell.CellID, for: indexPath) as? XIBExampleCell
        let repTestDetail: BookModel = bookArray[indexPath.row]
        cell?.leftLab.text = repTestDetail.desc ?? ""
        let imgeURL = "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666"
        cell?.rightImg.kf.setImage(with: URL(string: imgeURL), placeholder: UIImage(named: "AppIcon-mini"), options: nil, progressBlock: nil, completionHandler: nil)
        cell?.backgroundColor = UIColor.randomColor
        cell?.leftLab.numberOfLines = 0
        return cell ?? XIBExampleCell()
    }
}

// MARK: - Table view data delegate

extension HandyJsonTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 取消选中
    }
}
