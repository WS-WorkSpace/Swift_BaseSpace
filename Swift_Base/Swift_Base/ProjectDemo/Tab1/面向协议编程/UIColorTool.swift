//
//  ColorTool.swift
//  WS_Networing_Swift
//
//  Created by 王爽 on 2023/7/12.
//

import UIKit
// 定义扩展
extension UIColor: WSCompatible {}
extension WS where Base == UIColor {
    static func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        let color = UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
        return color
    }

    /// 将UIColor转换为16进制字符串。
    func toHexString() -> String {
        let components = self.base.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
 
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}

public extension UIColor {
    /// 通过16进制的字符串创建UIColor
    ///
    /// - Parameter hex: 16进制字符串，格式为#ececec
    convenience init(hex: String) {
//     static func hex(_ hex:String){
        let hex = (hex as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
         
        if hex.hasPrefix("#") {
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
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
  
    /// 将UIColor转换为16进制字符串。
    func toHexString() -> String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
  
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}
  
extension UIColor {
    /// 使用字符串方式生成自定义颜色。颜色格式0xAABBCCDD、#AABBCCDD
    /// 务必输入标准的颜色字符串格式。即#aabbcc、#aabbccdd
    convenience init(colorStr: String) {
        var colorString = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        /// 如果字符串不符合长度要求则返回默认颜色
        if colorString.count < 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
            return
        }
        
        /// 截取后面的颜色字符数据
        if colorString.hasPrefix("0x") || colorString.hasPrefix("0X") {
            colorString = (colorString as NSString).substring(from: 2)
        }
        if colorString.hasPrefix("#") {
            colorString = (colorString as NSString).substring(from: 1)
        }
        
        /// 判断截取后的颜色字符串长度
        if colorString.count < 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
            return
        }
        
        var rang = NSRange()
        rang.location = 0
        rang.length = 2
        
        /// 处理六位字符串长度，即没有透明度。否则处理包含字符透明度。
        if colorString.count == 6 {
            let rString = (colorString as NSString).substring(with: rang)
            rang.location = 2
            let gString = (colorString as NSString).substring(with: rang)
            rang.location = 4
            let bString = (colorString as NSString).substring(with: rang)
       
            var r: UInt64 = 0, g: UInt64 = 0, b: UInt64 = 0
            
            Scanner(string: rString).scanHexInt64(&r)
            Scanner(string: gString).scanHexInt64(&g)
            Scanner(string: bString).scanHexInt64(&b)

            print("AAA---  无透明度=r:\(rString),g:\(gString),b:\(bString)")
            
            let red = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue = CGFloat(b) / 255.0
            
            print("AAA---  无透明度RGB值=r:\(red),g:\(green),b:\(blue)")
            
            self.init(red: red, green: green, blue: blue, alpha: 1)
            return
        } else {
            let aString = (colorString as NSString).substring(with: rang)
            rang.location = 2
            let rString = (colorString as NSString).substring(with: rang)
            rang.location = 4
            let gString = (colorString as NSString).substring(with: rang)
            rang.location = 6
            let bString = (colorString as NSString).substring(with: rang)
            
            print("AAA---  有透明度=a:\(aString),r:\(rString),g:\(gString),b:\(bString)")
            
            var r: UInt64 = 0, g: UInt64 = 0, b: UInt64 = 0, a: UInt64 = 0
            
            Scanner(string: rString).scanHexInt64(&r)
            Scanner(string: gString).scanHexInt64(&g)
            Scanner(string: bString).scanHexInt64(&b)
            
            Scanner(string: aString).scanHexInt64(&a)
            
            let red = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue = CGFloat(b) / 255.0
            let alp = CGFloat(a) / 255.0
            
            print("AAA---  有透明度ARGB值=a:\(alp),r:\(red),g:\(green),b:\(blue)")
            
            self.init(red: red, green: green, blue: blue, alpha: alp)
            return
        }
    }
}
