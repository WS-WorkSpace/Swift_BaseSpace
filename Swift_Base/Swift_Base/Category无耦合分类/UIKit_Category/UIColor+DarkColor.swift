//
//  UIColor+DarkColor.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit

extension UIColor {
    /// 设置动态颜色
    static func RD_dynamicColor(_ lightColor: UIColor, _ darkColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return lightColor
                } else {
                    return darkColor
                }
            }
        } else {
            return lightColor
        }
    }

    /// 设置动态颜色（十六进制，color：支持“#123456” ）
    static func RD_dynamicHexColor(_ lightColor: String, _ darkColor: String) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor.hexColor(lightColor)
                } else {
                    return UIColor.hexColor(darkColor)
                }
            }
        } else {
            return UIColor.hexColor(lightColor)
        }
    }

    /// 设置动态颜色（十六进制，color：支持“#123456” ）
    static func RD_isdynamicHexColor(_ lightColor: String, _ darkColor: String) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor.hexColor(lightColor)
                } else {
                    return UIColor.hexColor(darkColor)
                }
            }
        } else {
            return UIColor.hexColor(lightColor)
        }
    }
}
