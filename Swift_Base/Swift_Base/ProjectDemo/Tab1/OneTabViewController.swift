//
//  OneTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class OneTabViewController: BaseTableViewController {
    var page = 1
    private  var vcArray:[String] {
        get{
            ["DemoListViewController", "TableListViewController", "CollectListViewController", "4", "5", "6", "7", "8"]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()

        view.backgroundColor = .white
        configModelArr = ["基本控件_Demo", "UITableView_Demo", "UICollcetionView_Demo", "4", "5", "6", "7", "8"]

        // MARK: - 点击cell的closure返回

        self.clickCellBlock = { (index: IndexPath, _: String) in
            let vc = NSString.RD_VC_ClassFromString(self.vcArray[index.row])
            if let _vc = vc {
                self.navigationController?.pushViewController(_vc, animated: true)
            }
        }
    }
}
