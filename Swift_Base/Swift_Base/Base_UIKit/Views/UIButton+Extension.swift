//
//  UIButton+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/29.
//

// https://www.jianshu.com/p/c815c31eff71

import UIKit

extension UIButton {
    static func creatButton(_ title: String,
                            _ titleColor: UIColor = .white,
                            _ frame: CGRect,
                            _ target: AnyClass.Type,
                            _ font:UIFont = UIFont.systemFont(ofSize: 16),
                            _ action: Selector) -> UIButton {
        let button = UIButton(frame: .zero)
        button.frame = frame
        button.titleLabel?.font = font
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.randomColor.cgColor
        button.backgroundColor = UIColor.randomColor
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}

// extension UIButton {
//
//     func addAction(for controlEvents: UIControlEvents,action:@escaping (UIButton)->()) {
//
//         objc_setAssociatedObject(self, cmButtonAssociatedkey, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//
//         self.addTarget(self, action: #selector(cmButtonClick), for: controlEvents)
//
//     }
//
//
//
//     func addAction(_ action:@escaping (UIButton)->()) {
//
//         objc_setAssociatedObject(self, cmButtonAssociatedkey, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//
//         self.addTarget(self, action: #selector(cmButtonClick), for: .touchUpInside)
//
//     }
//
//
//
//     func cmButtonClick() {
//
//         if let action = objc_getAssociatedObject(self, cmButtonAssociatedkey) as? (UIButton)->() {
//
//             action(self)
//
//         }
//
//     }
//
// }

/*
 private lazy var mButton = UIButton().then {
     let title = "UIButton"
     let titleColor = UIColor.randomColor
     $0.frame = .zero
     $0.titleLabel?.font = RD_Font(16)
     $0.setTitle(title, for: .normal)
     $0.setTitleColor(titleColor, for: .normal)
     $0.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
     $0.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
     $0.layer.cornerRadius = 5
     $0.layer.borderWidth = 1
     $0.layer.borderColor = UIColor.randomColor.cgColor
     $0.backgroundColor = UIColor.randomColor
     $0.addTarget(self, action: #selector(self.fpsClickButton(btn:)), for: .touchUpInside)
     view.addSubview($0)
 }
 */
