//
//  ObjectMapperViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/26.
//

import Alamofire
import UIKit

class ObjectMapperViewController: UIViewController {
    lazy var mTableView = {
        let tabview = UITableView()
        tabview.frame = view.bounds
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellID)
        return tabview
    }()

    lazy var items = [RepTestDetail]() // [Item]()
    var page = 1
    static let ItemCellID = "item"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mTableView)
    }

    func loadNewData() {
        let url = GlobalConfig.USERDETAIL_URL
        let parameters = ["key": "value"]
        DispatchQueue.global().async {
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { [weak self] response in
                guard let res = response.result.value, let weakSelf = self else { return }

                //                let arr = res["list"] as? [[String: Any]]
                //                guard let temparr = arr else { return }
                //                let array = Mapper<RepTestDetail>().mapArray(JSONArray: temparr)
                //                self?.items.removeAll()
                //                self?.items = array
                //                self?.tabview.reloadData()
                //                self?.tabview.mj_header?.endRefreshing()
                //                self?.page = 1

                weakSelf.mTableView.reloadData()
            })
        }
    }

//        let baseUrl = "http://rap2api.taobao.org/app/mock/303994/test/dbbooklist"
//        AFNetSessionManager.requestGETWithURL(url: baseUrl) { [weak self] responseObj, _ in
//            guard let tempObj = responseObj else { return }
//            let arr = tempObj["list"] as? [[String: Any]]
//            guard let temparr = arr else { return }
//            let array = Mapper<RepTestDetail>().mapArray(JSONArray: temparr)
//            self?.items.removeAll()
//            self?.items = array
//            self?.tabview.reloadData()
//            self?.tabview.mj_header?.endRefreshing()
//            self?.page = 1

//            print("-------->",model1?.id as Any)
//            print("-------->",model1?.avatar ?? "")
//            print("-------->",model1?.vip)
//            print("-------->",model1?.date)
//            print("-------->",model1?.images!)

//            let jsonlist = json["list"][0].rawString()
//            let model3 = Mapper<EvaluateModel>().map(JSONString: jsonlist!)

//    //        传string格式数据，也就是json字符串
//            let model4 = Mapper<EvaluateModel>().map(JSONString: JSONString! as String)
}

//        let dic = ["name" : "zhangsan", "age" : "22"]
////        字典转json字符串
//        let data : Data! = try? JSONSerialization.data(withJSONObject: dic, options: []) as Data?
//        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
//

// .response返回的是NSData
//        let dataRequest = AF.request(baseUrl, method: .get, parameters: ["":""], encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { [weak self] response in
//            guard let dicT =  response.value else{ return }
//            let json = JSON(dicT)
//            let arr = json["list"].arrayObject ?? []
//            //逃逸闭包用到self,以及它的属性需要捕获一下.[weak self]表示弱引用,弱引用肯定是可选类型
//            self?.items.removeAll()
//            self?.items.append(contentsOf: arr)
//            //            print(self?.items as Any)
//            self?.tabview.reloadData()
//            self?.tabview.mj_header?.endRefreshing()
//            self?.page = 1
//
//            print(self?.page as Any)
//        }

extension ObjectMapperViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.mj_footer?.isHidden = (items.count == 0)
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellID, for: indexPath)
        let repTestDetail: RepTestDetail = items[indexPath.row]

//        let dicT = items[indexPath.row] as? [String:Any]
//        guard let dicTemp = dicT else{ return cell}
//        let descString = dicTemp["desc"] as? String

        // 图片转换
        // let url = "tupian.webp"
        // let pngUrl = url.replacingOccurrences(of: ".webp", with: ".png")
        cell.imageView?.kf.setImage(with: URL(string: "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666"))
        //        print("--------__>",dicT)
        cell.textLabel?.text = repTestDetail.desc
        return cell
//        var tmp = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellID)//这里cell可能为空
//        if tmp == nil {
//            tmp = UITableViewCell(style: .value2, reuseIdentifier: Self.ItemCellID)
//        }
//        let cell = tmp!
    }
}

extension ObjectMapperViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
