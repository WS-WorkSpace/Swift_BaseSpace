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
        let textField = UITextField(frame: CGRectMake(30, 230, 100, 50))
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
    }
}
