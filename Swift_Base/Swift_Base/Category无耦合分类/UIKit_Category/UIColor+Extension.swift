//
//  UIColor+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit


public extension UIColor {
    convenience init(_ hexValue: Int, alphaValue: Float) {
        self.init(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255, green: CGFloat((hexValue & 0x00FF00) >> 8) / 255, blue: CGFloat(hexValue & 0x0000FF) / 255, alpha: CGFloat(alphaValue))
    }

    convenience init(_ hexValue: Int) {
        self.init(hexValue, alphaValue: 1)
    }

    static func rgbColor(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        return rgbColor(red, green, blue, 1)
    }

    static func rgbColor(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    static func hexColor(_ hexValue: Int, alphaValue: Float) -> UIColor {
        return UIColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255, green: CGFloat((hexValue & 0x00FF00) >> 8) / 255, blue: CGFloat(hexValue & 0x0000FF) / 255, alpha: CGFloat(alphaValue))
    }

    static func hexColor(_ hexValue: Int) -> UIColor {
        return hexColor(hexValue, alphaValue: 1)
    }
    static func grayColor(_ v: Int) -> UIColor {
        return UIColor.rgbColor(v, v, v)
    }

    /// 随机色
    static var randomColor: UIColor {
        UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }

    /// color：支持“#123456”
    class func hexColor(_ hexStr: String) -> UIColor {
        return UIColor.hexColor(hexStr, 1.0)
    }

    /// color：支持“#123456”
    class func hexColor(_ hexStr: String, _ alpha: CGFloat) -> UIColor {
        let hexString = hexStr.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

/*
 // MARK: - 颜色设置,全局变量

 /// RGB颜色设置：支持(255, 255, 255)
 func RD_Color(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
     return UIColor(red: CGFloat(r) / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
 }

 func RD_ColorA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
     return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
 }

 func RD_RandomColor() -> UIColor {
     return RD_Color(CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)))
 }

 func RD_GrayColor(_ v: CGFloat) -> UIColor {
     return RD_Color(v, v, v)
 }

 /// 十六进制颜色设置：支持#FF0000
  func RD_HexColor(_ rgbValue: String) -> UIColor? {
     return UIColor.RD_hexColor(rgbValue, alpha: 1.0)
  }

  func RD_HexColorA(_ rgbValue: String, _ a: CGFloat) -> UIColor? {
     return UIColor.RD_hexColor(rgbValue, alpha: a)
  }

 */
