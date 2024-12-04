//
//  SwiftMessagesViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/4.
//

import UIKit
import SwiftMessages
class SwiftMessagesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.warning)
        view.configureDropShadow()
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        view.configureContent(title: "Warning", body: "Consider yourself warned.", iconText: iconText)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        SwiftMessages.show(view: view)

//        let view = MessageView.viewFromNib(layout: .cardView)
//        view.configureTheme(.info) // 配置为主题风格
//        view.configureDropShadow() // 添加阴影效果
//        view.titleLabel?.text = "标题"
//        view.bodyLabel?.text = "内容"
//        view.iconLabel?.text = "图标文字"
//        /// view.iconImageView?.kf.setImage(with: URL(string: USER_IMG_URl))
//        view.iconImageView?.image = UIImage(named: "Alert_success")
//        view.button?.setTitle("确认", for: .normal)
//        view.buttonTapHandler = { _ in
//            print("点击了通知按钮")
//        }
//        SwiftMessages.show(view: view)

    }


}

