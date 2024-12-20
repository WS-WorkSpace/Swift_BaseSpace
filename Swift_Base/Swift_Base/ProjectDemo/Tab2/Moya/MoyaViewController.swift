//
//  MoyaViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/28.
//

import Moya
import UIKit

class MoyaViewController: UIViewController {
    fileprivate var bookJsonArray = [JSON]()
    lazy var mTableView: UITableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.MoyaItemCellID)
        return tabview
    }()

    lazy var mHeaderView: UIView = {
        let hView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 90))
        hView.backgroundColor = .magenta
        let leftBtn = UIButton.creatButton("简单使用", .white, 16, CGRectZero, self, #selector(leftButton))
        leftBtn.layer.cornerRadius = 7
        hView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(kScreenWidth/2 - 10, 80))
            make.left.equalTo(5)
            make.top.equalTo(5)
        }
        let rightBtn = UIButton.creatButton("封装使用", .white,16,CGRectZero, self, #selector(rightButton))
        rightBtn.layer.cornerRadius = 7
        hView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(kScreenWidth/2 - 10, 80))
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
        }

        return hView
    }()

    @objc func leftButton() {
        MoyaHttpCenter.request(API_W.getPageList(1)) { [weak self] json in
            mlog("点击左侧侧按钮")
            let jsonDate = JSON(json)
            self?.bookJsonArray.removeAll()
            self?.bookJsonArray = jsonDate["list"].arrayValue
            self?.mTableView.reloadData()
        } failure: { code, msg in
            mAllLog("code : \(code!)")
            mlog("message : \(msg)")
        }
    }

    @objc func rightButton() {
        mlog("点击右侧侧按钮")
        NetWorkRequest(API.getPageList(1), completion: { [weak p = self] data in
            let jsonDate = JSON(data)
            p?.bookJsonArray.removeAll()
            p?.bookJsonArray = jsonDate["list"].arrayValue
            p?.mTableView.reloadData()
        }) { errorString in
            mlog(errorString)
        }
    }

    static let MoyaItemCellID = "MoyaVCCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.tableHeaderView = mHeaderView
        view.addSubview(mTableView)
    }

    deinit {
        print("\(Self.self)已经释放")
    }
}

extension MoyaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookJsonArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.MoyaItemCellID, for: indexPath)
        let descString = bookJsonArray[indexPath.row]["desc"].stringValue
        cell.textLabel?.text = descString
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension MoyaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descString = bookJsonArray[indexPath.row]["desc"].stringValue
        let contentHeight = descString.RD_getStringHeight(kScreenWidth - 10 - 10, 20)
        let cellHeight = contentHeight + 10 + 10
        return cellHeight
    }
}
