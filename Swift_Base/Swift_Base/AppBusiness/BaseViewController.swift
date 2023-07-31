//
//  BaseViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/1.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigVersion.configIOS11(self)
        ConfigVersion.configIOS15()
    }
    
    /// 隐藏键盘
    func hideKeyboardWhenTapedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

}
