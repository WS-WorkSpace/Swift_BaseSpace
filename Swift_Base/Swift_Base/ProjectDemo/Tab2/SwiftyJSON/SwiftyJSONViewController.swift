//
//  Parse ModelViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/23.
//

import Alamofire
import SwiftyJSON
import UIKit

struct Book {
    var authorNumber: Int
    var authorName: String
    var desc: String
}

class SwiftyJSONViewController: BaseTableViewController {
    var bookArray = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
//        configModelArr = ["SwiftyJSON使用",
//                          "",
//                          "",
//                          "",
//                          ""]
        /// 读取本地数据
//        let dic = EasyTestModel.readJsonWithFileName("BookList", "json")
//        readLocalJSON()
        getNetModel()
    }

    /// 读取本地json数据
    func readLocalJSON() {
        let json = EasyTestModel.getLocalJSON("BookList", "json")
        updateModel(json)
    }

    func updateModel(_ json: JSON) {
        let bookArr = json["list"].arrayValue
        for element in bookArr {
            let num = element["num"].intValue
            let name = element["name"].stringValue
            let desc = element["desc"].stringValue
            let book = Book(authorNumber: num, authorName: name, desc: desc)
            bookArray.append(book)

            appendModelArr(name) // 列表title
            mTableView.reloadData()
        }
        print(bookArray)
    }

    func getNetModel() {
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]
        DispatchQueue.global().async {
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                // 处理响应结果
                if let value = response.result.value {
                    let json = JSON(value)
                    self.updateModel(json)
                }
                if let error = response.result.error {
                    print("Response error: \(error)")
                }

            })
        }
    }
}
