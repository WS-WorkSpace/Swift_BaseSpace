//
//  CustomXIBViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/12.
//

import UIKit

class CustomXIBViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        /// 1 customView add了 xibview
        let customView = CustomView()
        customView.frame = CGRectMake(10, distanceTop+130, kScreenWidth-20, 50)
        view.addSubview(customView)
        /// 2 view里面自定义Bundle方法
        let templateView = Template.loadFromNib()
        templateView.frame = CGRectMake(10, distanceTop+230, kScreenWidth-20, 50)
        view.addSubview(templateView)
        /// 3 view里Bundle扩展方法
        let myxibView: MyXibView = Bundle.loadView(fromNib: "MyXibView", withType: MyXibView.self)
        myxibView.frame = CGRectMake(10, distanceTop+330, kScreenWidth-20, 50)
        view.addSubview(myxibView)
        /// 4 view的协议扩展,添加Bundle创建方法
        let protocolLoadXibView = ProtocolLoadXibView.loadFromNib()
        protocolLoadXibView.frame = CGRectMake(10, distanceTop+430, kScreenWidth-20, 50)
        view.addSubview(protocolLoadXibView)
        /// 5 模版实现方式2
        let xibView = MyCustomXIBView.loadFromNib()
        xibView.frame = CGRectMake(10, distanceTop+530, kScreenWidth-20, 50)
        view.addSubview(xibView)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
