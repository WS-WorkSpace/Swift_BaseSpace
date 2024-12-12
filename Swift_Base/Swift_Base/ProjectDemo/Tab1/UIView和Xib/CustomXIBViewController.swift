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

        let customView:CustomView = CustomView()
        customView.frame = CGRectMake(10, distanceTop+130, kScreenWidth-20, 50)
        view.addSubview(customView)

        
        let templateView:Template = Template.loadFromNib()
        templateView.frame = CGRectMake(10, distanceTop+230, kScreenWidth-20, 50)
//        templateView.backgroundColor = .red
        view.addSubview(templateView)
        
        let myxibView:MyXibView = Bundle.loadView(fromNib: "MyXibView", withType: MyXibView.self)
        myxibView.frame = CGRectMake(10, distanceTop+330, kScreenWidth-20, 50)
        view.addSubview(myxibView)

        let protocolLoadXibView:ProtocolLoadXibView = ProtocolLoadXibView.loadFromNib()
        protocolLoadXibView.frame = CGRectMake(10, distanceTop+430, kScreenWidth-20, 50)
        view.addSubview(protocolLoadXibView)
        
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
