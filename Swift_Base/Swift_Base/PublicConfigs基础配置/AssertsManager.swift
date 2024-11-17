//
//  AssertsManager.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/17.
//

import UIKit

// typealias AM = AssertsManager
// enum AssertsManager {
//    enum string: String {
//        case add = "添加"
//    }
//    enum image: String {
//        case logo = "pic"
//    }
//    enum segue: String{
//        case login_main
//    }
// }
// extension UIImage {
//    convenience init?(_ name: AssertsManager.image) {
//        self.init(named: name.rawValue)
//    }
// }
// extension UIViewController {
//    func performSegue(withIdentifier identifier: AssertsManager.segue, sender: Any?) {
//        performSegue(withIdentifier: identifier.rawValue, sender: sender)
//    }
// }
// extension UIButton {
//    func setTitle(_ title: AssertsManager.string, for state: UIControl.State) {
//        setTitle(title.rawValue, for: state)
//    }
// }
//
//
// struct temp{
//    let img = UIImage(AssertsManager.image.logo)
//    let btn = UIButton(type: .custom)
////    btn.setTitle(R.string.add, for: .normal)
////    performSegue(withIdentifier: R.segue.login_main, sender: self)
// }

typealias AM = AssertsManager

enum AssertsManager {
    enum image {
        static var logo = UIImage(named: "tab4_select")
    }

    enum font {
        static func arial(_ size: CGFloat) -> UIFont? {
            UIFont(name: "Arial", size: size)
        }
    }
}

/* 使用示例
 let img = AM.image.logo          //let img = UIImage(named: "logo")
 let font = AM.font.arial(14)     //let font = UIFont(name: "Arial", size: 14)

 let imgView = UIImageView.init(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
 imgView.image = AM.image.logo
 view.addSubview(imgView)
 */
