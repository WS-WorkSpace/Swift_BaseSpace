//
//  OneTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class OneTabViewController: BaseTableViewController {
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()

        view.backgroundColor = .white
        configModelArr = ["1", "基本控件Demo", "网络请求Demo", "4", "5", "6", "7", "8"]
        var vcArray = ["1", "DemoListViewController", "NetWorkingListViewController", "4", "5", "6", "7", "8"]

        let item1 = UIBarButtonItem.RD_imageItem(imageName: navRightImage ?? ("tab5", "tab5_select"), target: self, action: #selector(self.demoListVC))
        let item2 = UIBarButtonItem.RD_textItem(title: "NetWoring", titleColor: .black, target: self, action: #selector(self.netWoringMethod))
        navigationItem.rightBarButtonItems = [item1, item2]

        let header = SelfRefreshGifHeader(refreshingBlock: self.loadNewData)
        header.beginRefreshing()
        mTableView.mj_header = header

        mTableView.mj_footer = SelfRefreshBackGifFooter(refreshingBlock: self.loadMoreData)

        // MARK: -

        self.clickCellBlock = { (index: IndexPath, str: String) in
            var vc = NSString.RD_VC_ClassFromString(vcArray[index.row])
            if let _vc = vc {
                self.navigationController?.pushViewController(_vc, animated: true)
            }
        }
    }

    @objc func netWoringMethod() {
        self.navigationController?.pushViewController(NetWorkingListViewController(), animated: true)
    }

    @objc func demoListVC() {
        self.navigationController?.pushViewController(DemoListViewController(), animated: true)
    }

    func loadNewData() {
        sleep(1)
        self.mTableView.mj_header?.endRefreshing()
    }

    func loadMoreData() {
        sleep(1)
        self.mTableView.mj_footer?.endRefreshing()
    }
}

//enum RunTime {
//    static func swiftClassFromString(className: String) -> UIViewController? {
//        // static let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] ?? ""
//
//        let preStr = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String
//        if var _preStr = preStr {
//            let vcClass = NSClassFromString(_preStr  + "." + className) as? UIViewController.Type
//            let vc = vcClass?.init()
//            return vc
//        }
//        return nil
//    }
//}
