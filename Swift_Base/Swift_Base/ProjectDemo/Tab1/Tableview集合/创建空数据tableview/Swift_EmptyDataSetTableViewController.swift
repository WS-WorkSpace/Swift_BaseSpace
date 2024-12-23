//
//  Swift_EmptyDataSetTableViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/23.
//

import UIKit

private struct Book {
    var authorNumber: Int
    var authorName: String
    var desc: String
}

class Swift_EmptyDataSetTableViewController: UIViewController {
    fileprivate var bookArray = [Book]()
    lazy var mTableView: BaseTableView = {
        let tabview = BaseTableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .white
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.EmptyDataCellCellID)
        return tabview
    }()

    static let EmptyDataCellCellID = "EmptyDataCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mTableView)
        setUpEmptyDetail()
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
    func setUpEmptyDetail(){
        mTableView.mReloadEmptyDataSet()
    }
    func getNetModel() {
        if AF.isNetwork() == false {
            self.setUpEmptyDetail()
            return
        }
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]
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

extension Swift_EmptyDataSetTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.EmptyDataCellCellID, for: indexPath)
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

extension Swift_EmptyDataSetTableViewController: UITableViewDelegate {
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
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
}
