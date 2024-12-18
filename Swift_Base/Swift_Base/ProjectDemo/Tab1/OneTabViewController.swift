//
//  OneTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class OneTabViewController: BaseTableViewController {
    var page = 1
    private var vcArray: [String] {
        ["DemoListViewController",
         "TableListViewController",
         "CollectListViewController",
         "Swift_Call_OC_ViewController",
         "OC_Call_Swift_ViewController",
         "MultithreadingViewController",
         "FuntionalProgrammingViewController",
         "POPViewController",
         "ReactiveProgrammingViewController",
         "MirrorViewController",
         "NVActivityIndicatorViewController",
         "ESPullToRefreshViewController",
         "SwiftMessagesViewController",
         "CustomXIBViewController"]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()

        // PostMan,Mock本地数据的测试用例
        /**
         let url = "https://90b8a562-c986-4e95-b3cb-9a1dca954854.mock.pstmn.io/mock_login"
         Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response(completionHandler: { response in
             if let res = response.data {
                 print(res)
                 let json = JSON(res)
                 print(json)
             }
         })
         */

        view.backgroundColor = .white
        configModelArr = ["基本控件_Demo",
                          "UITableView_Demo",
                          "UICollcetionView_Demo",
                          "Swift调用OC",
                          "OC调用Swift",
                          "多线程",
                          "函数式编程",
                          "面向协议编程",
                          "响应式编程",
                          "反射",
                          "菊花动画",
                          "ESPullToRefresh",
                          "SwiftMessages通知栏",
                          "UIView和XIB"]

        // MARK: - 点击cell的closure返回

        self.clickCellBlock = { (index: IndexPath, _: String) in
            let vc = NSString.RD_VC_ClassFromString(self.vcArray[index.row])
            if let _vc = vc {
                self.navigationController?.pushViewController(_vc, animated: true)
            }
            // 创建OC的Viewcontroller
            let _vcTemp = self.vcArray[index.row]
            // OC_Call_Swift_ViewController是OC的类单独处理,忽略toast提示没有这个类
            if _vcTemp == "OC_Call_Swift_ViewController" {
//                let vc:UIViewController  = NSClassFromString(_vcTemp).init()
                let vc: UIViewController = OC_Call_Swift_ViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
