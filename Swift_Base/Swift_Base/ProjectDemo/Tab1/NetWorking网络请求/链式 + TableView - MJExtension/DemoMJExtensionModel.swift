////
////  DemoMJExtensionModel.swift
////  Swift_Base
////
////  Created by 王爽 on 2023/8/14.
////
//
//import UIKit
//import MJExtension
//
//@objc(DemoMJExtensionModel)
//@objcMembers
//
//class DemoMJExtensionModel: NSObject {
//    dynamic var id :String = ""
//    var title:String?
//    var text:String = ""
//    var img:String = ""
//
//    // make sure to use `dynamic` attribute for basic type & must use as Non-Optional & must set initial value
//    dynamic var isSpecialAgent: Bool = false
//    dynamic var age: Int = 0
//    dynamic var ID: Int = 0
//
//    var cellHeight:CGFloat {
//        get {
//            let height =  text.RD_getStringHeight(kScreenWidth-125.0, 17.0)
////            JhLog("height : \(height)")
//            return height>50 ? height:50.0
//        }
//    }
//
//}
