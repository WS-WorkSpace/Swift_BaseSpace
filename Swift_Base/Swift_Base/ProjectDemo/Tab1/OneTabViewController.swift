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
         "ReactiveProgrammingViewController"]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()

        view.backgroundColor = .white
        configModelArr = ["基本控件_Demo",
                          "UITableView_Demo",
                          "UICollcetionView_Demo",
                          "Swift调用OC",
                          "OC调用Swift",
                          "多线程",
                          "函数式编程",
                          "面向协议编程",
                          "响应式编程"]

        // MARK: - 点击cell的closure返回

        self.clickCellBlock = { (index: IndexPath, _: String) in
            let vc = NSString.RD_VC_ClassFromString(self.vcArray[index.row])
            if let _vc = vc {
                self.navigationController?.pushViewController(_vc, animated: true)
            }
            // 创建OC的Viewcontroller
            let _vcTemp = self.vcArray[index.row]
            if _vcTemp == "OC_Call_Swift_ViewController" {
//                let vc:UIViewController  = NSClassFromString(_vcTemp).init()
                let vc: UIViewController = OC_Call_Swift_ViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
