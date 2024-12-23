//
//  Parse ModelViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/23.
//

import SwiftyJSON
import UIKit

private struct Book {
    var authorNumber: Int
    var authorName: String
    var desc: String
}

class SwiftyJSONViewController: UIViewController {
    fileprivate var bookArray = [Book]()
    lazy var mTableView: UITableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.SwiftyJSONCellID)
        return tabview
    }()

    static let SwiftyJSONCellID = "SwiftyJSONCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mTableView)
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
        }
        mTableView.reloadData()
    }

    func getNetModel() {
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]
//        DispatchQueue.global().async {
//            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
//                // 处理响应结果
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    self?.bookArray.removeAll()
//                    self.updateModel(json)
//                }
//                if let error = response.result.error {
//                    print("Response error: \(error)")
//                }
//
//            })
//        }
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response(completionHandler: { [weak self] response in
            if let res = response.data {
                print(res)
                let json = JSON(res)
                print(json)
                self?.bookArray.removeAll()
                self?.updateModel(json)
            }
        })
    }

    deinit {
        print("\(Self.self)已经释放")
    }
}

extension SwiftyJSONViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.SwiftyJSONCellID, for: indexPath)
        let descString = bookArray[indexPath.row].desc
        cell.textLabel?.text = descString
        cell.textLabel?.numberOfLines = 0
        // 图片转换
        // let url = "tupian.webp"
        // let pngUrl = url.replacingOccurrences(of: ".webp", with: ".png")
//        cell.imageView?.kf.setImage(with: URL(string: "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666"))
        return cell
    }
}

extension SwiftyJSONViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descString = bookArray[indexPath.row].desc
        let contentHeight = descString.RD_getStringHeight(kScreenWidth - 10 - 10, 20)
        let cellHeight = contentHeight + 10 + 10
        return cellHeight
    }
    // 设置cell的显示 3D缩放动画
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 设置cell的显示动画为3D缩放
        // xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        // 设置动画时间为0.25秒，xy方向缩放的最终值为1
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
        })
    }
}
