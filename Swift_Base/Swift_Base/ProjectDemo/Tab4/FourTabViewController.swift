//
//  FourTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit
class FourTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let textField: UITextField = UITextField.init(frame: CGRectMake(30, 230, 100, 50))
        textField.text = "asdasd"
        textField.backgroundColor = .green
        view.addSubview(textField)
        
        let btn = UIButton()
        btn.backgroundColor = UIColor.red
        self.view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerX.equalTo(self.view).offset(0)
//            make.size.equalTo(CGSizeMake(100, 50))
            make.width.equalTo(100)
            make.height.equalTo(50)

            make.top.equalTo(self.view.snp_top).offset(150)
        }

        let customView:CustomView = CustomView()
        customView.frame = CGRectMake(10, distanceTop+230, kScreenWidth-20, 50)
        view.addSubview(customView)

        
        let templateView:Template = Template.loadFromNib()
        templateView.frame = CGRectMake(10, distanceTop+330, kScreenWidth-20, 50)
//        templateView.backgroundColor = .red
        view.addSubview(templateView)
        
        let myxibView:MyXibView = Bundle.loadView(fromNib: "MyXibView", withType: MyXibView.self)
        myxibView.frame = CGRectMake(10, distanceTop+430, kScreenWidth-20, 50)
        view.addSubview(myxibView)

        
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
