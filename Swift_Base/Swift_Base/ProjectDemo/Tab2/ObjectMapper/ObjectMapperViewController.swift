//
//  ObjectMapperViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/26.
//

import ObjectMapper
import UIKit

class ObjectMapperViewController: UIViewController {
    lazy var mTableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellID)
        return tabview
    }()

    lazy var userItems = [UserInfo]() // [Item]()
    var page = 1
    static let ItemCellID = "item"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mTableView)
        loadNewData()
    }

    func loadNewData() {
        let url = GlobalConfig.USERDETAIL_URL
        let parameters = ["key": "value"]
        DispatchQueue.global().async {
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { [weak self] response in
//                guard let res = response.result.value, let weakSelf = self else { return }
//                let dic = res as? [String: Any]
//                let arr = dic?["list"] as? [[String: Any]]
//                let arrayTemp = Mapper<UserInfo>().mapArray(JSONArray: arr!)
//                weakSelf.userItems = dicTemp["list"]

                guard let res = response.result.value, let weakSelf = self else { return }
                let focusList = Mapper<FocusList>().map(JSONObject: res)
                guard let userItemsTemp = focusList?.list else { return }
                // 逃逸闭包用到self,以及它的属性需要捕获一下.[weak self]表示弱引用,弱引用肯定是可选类型
                weakSelf.userItems.removeAll()
                weakSelf.userItems = userItemsTemp
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
        return userItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellID, for: indexPath)
        let userInfo: UserInfo = userItems[indexPath.row]
        // 图片转换
        let avatarURL = userInfo.avatar
        let avatarText = userInfo.text
        cell.imageView?.kf.setImage(with: URL(string: avatarURL ?? ""))
        cell.textLabel?.text = avatarText ?? ""
        cell.textLabel?.numberOfLines = 0

        if indexPath.row == 0 {
            print("----1---->", userInfo.id as Any) // Optional(1000)
            print("----2---->", userInfo.avatar as Any) // Optional("4e7f0c83ly8g1ho507078j20ro0rojtq.jpg")
            print("----3---->", userInfo.vip as Any) // Optional(true)
            print("----4---->", userInfo.name as Any) // Optional("娄艺潇")
            print("----5---->", userInfo.date as Any) // Optional(1970-01-01 00:33:40 +0000)
            print("----6---->", userInfo.text as Any) // Optional("潮汕菜太好吃了")
            print("----7---->", userInfo.images as Any) // Optional([4e7f0c83gy1gam2misv31j21hc0u016k.jpg, 4e7f0c83gy1gam2mjhk8zj21hc0v6wnx.jpg, 4e7f0c83gy1gam2ml6nucj22tc240kjl.jpg, 4e7f0c83gy1gam2mn58d3j22tc240qv5.jpg, 4e7f0c83gy1gam2mp0x4pj22tc240u0x.jpg, 4e7f0c83gy1gam2mr1b81j22tc2407wi.jpg])
        }

        return cell
    }
}

extension ObjectMapperViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
