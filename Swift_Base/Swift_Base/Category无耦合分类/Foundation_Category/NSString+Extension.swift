//
//  NSString+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import Foundation
import UIKit

extension NSString {
    /// 判空
    public var RD_isEmpty: Bool {
        // 字符串的开头和结尾删除空格，请执行以下操作
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }

    /// 一串字符在固定宽度下，正常显示所需要的高度
    func RD_getStringHeight(_ width: CGFloat, _ font: CGFloat) -> CGFloat {
        let size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
        return size.height
    }

    /// 一串字符在一行中正常显示所需要的宽度
    func RD_getStringWidth(_ font: CGFloat) -> CGFloat {
        let size = self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
        return size.width
    }

    class func RD_classFromString(_ className: String, moduleName: String? = nil) -> AnyClass {
        /// 获取命名空间
        var namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        if let name = moduleName {
            namespace = name
        }

        /// 根据命名空间传来的字符串先转换成anyClass
        let cls: AnyClass = NSClassFromString(namespace + "." + className)!
        // 在这里已经可以return了   返回类型:AnyClass!
        return cls
    }

    /// 字符串转换为类
    ///
    /// - Parameter className: 类名字符串
    /// - Returns: 类对象
    class func RD_VC_ClassFromString(_ className: String) -> UIViewController? {
        /// 获取命名空间
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        /// 根据命名空间传来的字符串先转换成anyClass
        let cls: AnyClass? = NSClassFromString(namespace + "." + className)
        // 在这里已经可以return了   返回类型:AnyClass!
        // return cls;
        /// 转换成 明确的类
        let vcClass = cls as? UIViewController.Type
        /// 返回这个类的对象
        if let _vcClass = vcClass {
            return _vcClass.init()
        } else {
            Toast.toast("没有\(className)这个类", duration: 2.8)
            return nil
        }
    }

    /* 如果喜欢程序crash提示可以换
     class func RD_VC_ClassFromString(_ className: String) -> UIViewController! {
         /// 获取命名空间
         let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
         /// 根据命名空间传来的字符串先转换成anyClass
         let cls: AnyClass = NSClassFromString(namespace + "." + className)!
         // 在这里已经可以return了   返回类型:AnyClass!
         // return cls;
         /// 转换成 明确的类
         let vcClass = cls as! UIViewController.Type
         /// 返回这个类的对象
         return vcClass.init()
     }
     */

    @discardableResult
    class func RD_VC_ClassFromStringWithModuleName(_ className: String, moduleName: String? = nil) -> UIViewController! {
        /// 获取命名空间
        var namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        if let name = moduleName {
            namespace = name
        }

        /// 根据命名空间传来的字符串先转换成anyClass
        let cls: AnyClass = NSClassFromString(namespace + "." + className)!
        // 在这里已经可以return了   返回类型:AnyClass!
        // return cls;
        /// 转换成 明确的类
        let vcClass = cls as! UIViewController.Type
        /// 返回这个类的对象
        return vcClass.init()
    }

    /// 反射VC初始化并且赋值
    /// - Parameters:
    ///   - moduleName: 组件boundle名称，不传则为默认命名空间
    ///   - vcName: VC名称
    ///   - dic: 参数字典//由于是KVC赋值，必须要在参数上标记@objc
    /*
     @discardableResult
     public func initVC(_ vcName: String,
                        moduleName: String? = nil,
                        dic: [String : Any]? = nil) -> UIViewController?{

         var namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
         if let name = moduleName {
             namespace = name
         }

         let className = "\(namespace).\(vcName)"
         guard let cls = NSClassFromString(className) as? UIViewController.Type else { return nil  }
         let controller = cls.init()
         setObjectParams(obj: controller, paramsDic: dic)
         return controller
     }
      */
}
