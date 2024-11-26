//
//  CodableViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/26.
//

import UIKit

class CodableViewController: UIViewController {
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
        DispatchQueue.global().async {
//            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response(completionHandler: { [weak self] response in
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { [weak self] response in
                guard let json = response.result.value, let weakSelf = self else { return }
                guard let dic = json as? [String: Any] else { return }
                let bookList: BookList? = BookList.convertFromDict(dict: dic)
                guard let bookListTemp = bookList?.list else { return }
                weakSelf.bookArray.removeAll()
                weakSelf.bookArray = bookListTemp
                weakSelf.mTableView.reloadData()

//                guard let dicT = dic else { return }
//                guard let arrT = dicT["list"] as? [[String: Any]] else { return }
//                let dicM = arrT[0]
//
//                let bookDetail: BookDetail? = BookDetail.convertFromDict(dict: dicM)
//                print(">>>>>", bookDetail?.num) // Optional(26)
//                print(">>>>>", bookDetail?.name) // Optional("史敏")
//                print(">>>>>", bookDetail?.desc) // Optional("即建位表就油见家周心别严通眼等越看)
//                let myDic = bookDetail?.convertToDict()
//                print("model转换为DIctionary:", myDic) //

            })
        }
    }

    deinit {
        print("SwiftyJSONViewController已经释放")
    }
}

extension CodableViewController: UITableViewDataSource {
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

extension CodableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descString = bookArray[indexPath.row].desc
        let contentHeight = descString.RD_getStringHeight(kScreenWidth - 10 - 10, 20)
        let cellHeight = contentHeight + 10 + 10
        return cellHeight
    }
}
