//
//  HandyJsonViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit
import Alamofire
import HandyJSON

class HandyJsonViewController: UIViewController {
    lazy var tabview = UITableView()
    lazy var items = [String]()
//    lazy var items = [HandyJsonModel]()   //[Item]()
    var page = 1
    static let ItemCellID = "itemHandyJson"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        AFNetSessionManager.shared.setBaseConfig {
//            (config:BaseConfig) in
//            config.baseServer = ""
//            config.baseParameters = ["A":"B"]
//            config.timeout = 30.0
//            config.consoleLog = false
//        }
        items = ["1","2","3","4","5","6","7"]
        
        tabview.frame = view.bounds
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellID)
        view.addSubview(tabview)
        
        let header = SelfRefreshGifHeader(refreshingBlock: self.loadNewData)
        header.beginRefreshing()
        tabview.mj_header = header
        
        tabview.mj_footer = SelfRefreshBackGifFooter(refreshingBlock: self.loadMoreData)

    }
    func loadNewData() -> Void {
        sleep(1)
        self.tabview.mj_header?.endRefreshing()

//        let baseUrl = "http://rap2api.taobao.org/app/mock/303994/test/dbbooklist"
//        AFNetSessionManager.requestGETWithURL(url: baseUrl) { [weak self] responseObj, error in
//            guard let resObj = TotalModel.deserialize(from: responseObj) else { return }
//            self?.items.removeAll()
//            self?.items = resObj.list
//            self?.tabview.reloadData()
//            self?.tabview.mj_header?.endRefreshing()
//            self?.page = 1
//        }
    }
    func loadMoreData() -> Void {
        sleep(1)
        self.tabview.mj_footer?.endRefreshing()
//        let _ = page + 1
//        let baseUrl = "http://rap2api.taobao.org/app/mock/303994/test/dbbooklist"
//        //.response返回的是NSData
//        AF.request(baseUrl, method: .get, parameters: ["":""], encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { [weak self] response in
//            guard let dicT =  response.value else{ return }
//            let json = JSON(dicT)
//            let arr = json["list"].arrayObject ?? []
//            self?.items.append(contentsOf: arr)
//            self?.tabview.reloadData()
//            self?.tabview.mj_footer?.endRefreshing()
//            self?.page += 1
//            print(self?.page ?? 1)
//        }
    }
    
    
}
extension HandyJsonViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "aaaa"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.mj_footer?.isHidden = (items.count == 0)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: Self.ItemCellID, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]

//        let repTestDetail:HandyJsonModel = items[indexPath.row]
//        cell.textLabel?.text = repTestDetail.desc

        //图片转换
        //let url = "tupian.webp"
        //let pngUrl = url.replacingOccurrences(of: ".webp", with: ".png")
//        cell.imageView?.kf.setImage(with: URL(string: "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666"))
        //        print("--------__>",dicT)
        return cell
    }
}
extension HandyJsonViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
