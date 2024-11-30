//
//  AlamofireViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/28.
//

import UIKit

class AlamofireViewController: UIViewController {
    fileprivate var bookJsonArray = [JSON]()
    lazy var mTableView: UITableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.AlamofireItemCellID)
        return tabview
    }()

    lazy var mHeaderView: UIView = {
        let hView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 90))
        hView.backgroundColor = .magenta
        let leftBtn = UIButton.creatButton("简单使用", .white, CGRectZero, self, #selector(leftButton))
        leftBtn.layer.cornerRadius = 7
        hView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(kScreenWidth/2 - 10, 80))
            make.left.equalTo(5)
            make.top.equalTo(5)
        }
        let rightBtn = UIButton.creatButton("封装使用", .white, CGRectZero, self, #selector(rightButton))
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
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]
        DispatchQueue.global().async {
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { [weak self] response in
                guard let json = response.result.value, let weakSelf = self else { return }
                let jasonData = JSON(json)
                weakSelf.bookJsonArray.removeAll()
                weakSelf.bookJsonArray = jasonData["list"].arrayValue
                weakSelf.mTableView.reloadData()
            })
        }
    }

    @objc func rightButton() {
        let url = "http://rap2api.taobao.org/" + "app/mock/303994/test/dbbooklist"
        let mSuccess: (JSON) -> Void = {
            [weak self] json in
            let jasonData = JSON(json)
            self?.bookJsonArray.removeAll()
            self?.bookJsonArray = jasonData["list"].arrayValue
            self?.mTableView.reloadData()

        }
        let mFailure: (Int?, String) -> Void = {
            errorCode, msg in
            mLog(errorCode ?? -999)
            mLog(msg)
        }
        FPNetWorkRequest.url(url).requestType(.get).params(nil).success(mSuccess).failure(mFailure).request()
    }

    static let AlamofireItemCellID = "AlamofireVCCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mTableView)
        mTableView.tableHeaderView = mHeaderView
    }

    deinit {
        print("\(Self.self)已经释放")
    }
}

extension AlamofireViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookJsonArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.AlamofireItemCellID, for: indexPath)
        let descString = bookJsonArray[indexPath.row]["desc"].stringValue
        cell.textLabel?.text = descString
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension AlamofireViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descString = bookJsonArray[indexPath.row]["desc"].stringValue
        let contentHeight = descString.RD_getStringHeight(kScreenWidth - 10 - 10, 20)
        let cellHeight = contentHeight + 10 + 10
        return cellHeight
    }
}
