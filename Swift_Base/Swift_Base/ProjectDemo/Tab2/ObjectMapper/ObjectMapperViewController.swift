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
//                guard let arrT = arr else { return }
//                weakSelf.userItems.removeAll()
//                weakSelf.userItems = Mapper<UserInfo>().mapArray(JSONArray: arrT)
//                weakSelf.mTableView.reloadData()

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

    deinit {
        print("\(Self.self)已经释放")
    }
}

extension ObjectMapperViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellID)
        if cell == nil {
            cell = UITableViewCell(style: .value2, reuseIdentifier: Self.ItemCellID)
        }

        let userInfo: UserInfo = userItems[indexPath.row]
        var avatarURL = userInfo.avatar
        let avatarText = userInfo.text

        // 来临时换个固定图片
        // 这里重载过后才会变成.value2的cell,有显示bug
        avatarURL = "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666#/"
        // 图片转换
         let pngUrl = avatarURL?.replacingOccurrences(of: ".webp", with: ".png")
        cell?.imageView?.kf.setImage(with: URL(string: pngUrl ?? ""))

        cell?.textLabel?.text = avatarText ?? ""
        cell?.textLabel?.numberOfLines = 0
        return cell!

//        if indexPath.row == 0 {
//            print("----1---->", userInfo.id as Any) // Optional(1000)
//            print("----2---->", userInfo.avatar as Any) // Optional("4e7f0c83ly8g1ho507078j20ro0rojtq.jpg")
//            print("----3---->", userInfo.vip as Any) // Optional(true)
//            print("----4---->", userInfo.name as Any) // Optional("娄艺潇")
//            print("----5---->", userInfo.date as Any) // Optional(1970-01-01 00:33:40 +0000)
//            print("----6---->", userInfo.text as Any) // Optional("潮汕菜太好吃了")
//            print("----7---->", userInfo.images as Any) // Optional([4e7f0c83gy1gam2misv31j21hc0u016k.jpg, 4e7f0c83gy1gam2mjhk8zj21hc0v6wnx.jpg, 4e7f0c83gy1gam2ml6nucj22tc240kjl.jpg, 4e7f0c83gy1gam2mn58d3j22tc240qv5.jpg, 4e7f0c83gy1gam2mp0x4pj22tc240u0x.jpg, 4e7f0c83gy1gam2mr1b81j22tc2407wi.jpg])
//        }
    }
}

extension ObjectMapperViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
