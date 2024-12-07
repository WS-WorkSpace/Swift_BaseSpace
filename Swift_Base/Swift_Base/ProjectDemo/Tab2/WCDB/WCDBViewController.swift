//
//  WCDBViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/4.
//

import UIKit
import WCDBSwift

class WCDBViewController: UIViewController {
    fileprivate var bookArray = [ExampleItem]()
    lazy var mTableView: UITableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.SwiftyJSONCellID)

        tabview.tableHeaderView = mTableHeaderView
        return tabview
    }()

    lazy var mTableHeaderView = {
        let headerView = WCDBHeaderView.loadFromNib()
        headerView.frame = CGRectMake(0, 0, kScreenWidth, 200)
        return headerView
    }()

    static let SwiftyJSONCellID = "WCDBCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mTableView)
        // 调用单例会创建数据库
        // createTable创建表
        DBManager.shared.createTable(name: "ExampleItem", model: ExampleItem.self)

        readLocalDataBase()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .WCDBHeaderViewNotification, object: nil)
    }

    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo, let value = userInfo["key"] as? String {
            print("接收到传递的通知: \(value)")
            readLocalDataBase()
        }
    }

    /// 读取本地数据库
    func readLocalDataBase() {
        do {
            let allObjects: [ExampleItem] = try DBManager.shared.db.getObjects(on: ExampleItem.Properties.all, fromTable: "\(ExampleItem.self)")
            let condition: Condition = ExampleItem.Properties.authorNumber < 50 // && ExampleItem.Properties.authorName == "abc"
            let allObjectsA: [ExampleItem] = try DBManager.shared.db.getObjects(on: ExampleItem.Properties.all, fromTable: "ExampleItem", where: condition, limit: 10, offset: 0)
//            let _ = allObjectsA.map {
//                print($0.authorNumber ?? 0)
//                print($0.authorName ?? "")
//            }
            bookArray = allObjects
            mTableView.reloadData()
        } catch {}
    }

//    func updateModel(_ json: JSON) {
//        let bookArr = json["list"].arrayValue
//        for element in bookArr {
//            let num = element["num"].intValue
//            let name = element["name"].stringValue
//            let desc = element["desc"].stringValue
//            let book = Book(authorNumber: num, authorName: name, desc: desc)
//            bookArray.append(book)
//        }
//        mTableView.reloadData()
//    }

//    func getNetModel() {
//        let url = GlobalConfig.BOOKLIST_URL
//        let parameters = ["key": "value"]
    ////        DispatchQueue.global().async {
    ////            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
    ////                // 处理响应结果
    ////                if let value = response.result.value {
    ////                    let json = JSON(value)
    ////                    self?.bookArray.removeAll()
    ////                    self.updateModel(json)
    ////                }
    ////                if let error = response.result.error {
    ////                    print("Response error: \(error)")
    ////                }
    ////
    ////            })
    ////        }
//        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response(completionHandler: { [weak self] response in
//            if let res = response.data {
    ////                print(res)
//                let json = JSON(res)
    ////                print(json)
//                self?.bookArray.removeAll()
//                self?.updateModel(json)
//            }
//        })
//    }

    deinit {
        print("\(Self.self)已经释放")
        NotificationCenter.default.removeObserver(self)
    }
}

extension WCDBViewController: UITableViewDataSource {
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

extension WCDBViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descString = bookArray[indexPath.row].desc ?? ""
        let contentHeight = descString.RD_getStringHeight(kScreenWidth - 10 - 10, 20)
        let cellHeight = contentHeight + 10 + 10
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let tableName = "ExampleItem"
//        MYDB.createTable(name: "ExampleItem", model: ExampleItem.self)
//        let object = ExampleItem()
//        object.authorNumber = Int.random(in: 0...3)
//        let arr = ["Jim","Rose","Tom","jack","Li"]
//        object.authorName = arr.randomElement()
//        let description = ["一个数学家","小学生","程序员","艺人","吃瓜群众"]
//        object.desc = description.randomElement()
//        //纯插入操作，由于设置了identifier为主键，所以identifier必须唯一，不然插入必失败并打印错误
//        MYDB.insert(objects: object, intoTable: tableName)
//        MYDB.insert(objects: object, intoTable: tableName)
//        print(object.lastInsertedRowID)
    }
}
