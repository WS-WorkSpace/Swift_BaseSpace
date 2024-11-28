//
//  MoyaViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/28.
//

import UIKit

class MoyaViewController: UIViewController {
    fileprivate var bookArray = [BookDetail]()
    lazy var mTableView: UITableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellID)
        return tabview
    }()

    static let ItemCellID = "SwiftyJSONCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mTableView)
        getNetModel()
    }

    func getNetModel() {
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]
        mLog(API.getPageList(1))
        JhHttpTool.request(API.getPageList(1)) {[weak self] json in
//            self?.mTextView.text = String(describing: JSON(json))
            mAllLog(JSON(json))
        } failure: {code, msg in
            mAllLog("code : \(code!)")
            mLog("message : \(msg)")
        }


    }

    deinit {
        print("SwiftyJSONViewController已经释放")
    }
}

extension MoyaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellID, for: indexPath)
        let descString = bookArray[indexPath.row].desc
        cell.textLabel?.text = descString
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension MoyaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descString = bookArray[indexPath.row].desc
        let contentHeight = descString.RD_getStringHeight(kScreenWidth - 10 - 10, 20)
        let cellHeight = contentHeight + 10 + 10
        return cellHeight
    }
}

