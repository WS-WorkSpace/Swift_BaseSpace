////
////  UIButton+Extension.swift
////  Swift_Base
////
////  Created by 王爽 on 2024/11/29.
////
//
// import Foundation
////https://www.jianshu.com/p/c815c31eff71
/// *
// 目录：
// 1、基本的扩展
// 2、链式调用
// 3、UIButton 图片 与 title 位置关系(提示：title和image要在设置布局关系之前设置)
// 4、自带倒计时功能的 Button
// */
//
//
//// MARK:- 一、基本的扩展
// public extension UIButton {
//    enum SmallButtonType {
//        case red
//        case pink
//    }
//
//    // MARK: 1.1、创建一个带颜色的 Button
//    /// 创建一个带颜色的 Button
//    /// - Parameters:
//    ///   - type: 类型
//    ///   - height: 高度
//    /// - Returns: 返回自身
//    @discardableResult
//    static func small(type: SmallButtonType = .red, height: CGFloat = 45) -> UIButton {
//        let normalColor: UIColor
//        let disabledColor: UIColor
//        let lineTypeNormal: LineType
//        let lineTypeDisable: LineType
//        let titleColorNormal: UIColor
//        let titleColorDisable: UIColor
//
//        switch type {
//        case .red:
//            normalColor = .hexStringColor(hexString: "#E54749")
//            disabledColor = .hexStringColor(hexString: "#CCCCCC")
//            lineTypeNormal = .none
//            lineTypeDisable = .none
//            titleColorNormal = .white
//            titleColorDisable = .white
//        case .pink:
//            normalColor = .hexStringColor(hexString: "#FFE8E8")
//            disabledColor = .hexStringColor(hexString: "#CCCCCC")
//            lineTypeNormal = .color(.hexStringColor(hexString: "#F6CDCD"))
//            lineTypeDisable = .color(.hexStringColor(hexString: "#9C9C9C"))
//            titleColorNormal = .hexStringColor(hexString: "#E54749")
//            titleColorDisable = .white
//        }
//
//        let btn = UIButton(type: .custom).font(.systemFont(ofSize: 16))
//        btn.setTitleColor(titleColorNormal, for: .normal)
//        btn.setTitleColor(titleColorDisable, for: .disabled)
//        btn.setBackgroundImage(drawSmallBtn(color: normalColor, height: height, lineType: lineTypeNormal), for: .normal)
//        btn.setBackgroundImage(drawSmallBtn(color: disabledColor, height: height, lineType: lineTypeDisable), for: .disabled)
//        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 13, right: 0)
//        return btn
//    }
//
//    // MARK: 1.2、创建一个常规的 Button
//    /// 创建一个常规的 Button
//    /// - Returns: 返回自身
//    static func normal() -> UIButton {
//        let btn = UIButton(type: .custom).font(.boldSystemFont(ofSize: 18))
//        btn.setTitleColor(.white, for: .normal)
//        btn.setTitleColor(.white, for: .disabled)
//        btn.setBackgroundImage(drawNormalBtn(color: .hexStringColor(hexString: "#E54749"))?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)), for: .normal)
//        btn.setBackgroundImage(drawNormalBtn(color: .hexStringColor(hexString: "#CCCCCC"))?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)), for: .disabled)
//        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
//        return btn
//    }
//
//    private static func drawSmallBtn(color: UIColor, height: CGFloat, lineType: LineType) -> UIImage? {
//        let rect = CGRect(x: 0, y: 0, width: 200, height: height + 20)
//        let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 3, width: 180, height: height), cornerRadius: height / 2)
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
//        let context = UIGraphicsGetCurrentContext()
//        context?.setFillColor(color.cgColor)
//        context?.addPath(path.cgPath)
//        context?.setShadow(offset: CGSize(width: 1, height: 4), blur: 10, color: color.withAlphaComponent(0.5).cgColor)
//        context?.fillPath()
//        switch lineType {
//        case let .color(color):
//            color.setStroke()
//            path.lineWidth = kPixel
//            path.stroke()
//        default:
//            break
//        }
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return img
//    }
//
//    private static func drawNormalBtn(color: UIColor) -> UIImage? {
//        let rect = CGRect(x: 0, y: 0, width: 260, height: 50)
//        let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 3, width: 240, height: 40), cornerRadius: 3)
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
//        let context = UIGraphicsGetCurrentContext()
//        context?.setFillColor(color.cgColor)
//        context?.addPath(path.cgPath)
//        context?.setShadow(offset: CGSize(width: 1, height: 2), blur: 6, color: color.withAlphaComponent(0.5).cgColor)
//        context?.fillPath()
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return img
//    }
// }
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
//

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
