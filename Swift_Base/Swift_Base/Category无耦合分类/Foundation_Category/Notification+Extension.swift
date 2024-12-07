//
//  Notification+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/7.
//

import Foundation


// 定义通知名称
extension Notification.Name {
    static let WCDBHeaderViewNotification = Notification.Name("WCDBHeaderViewNotification")
}
//// 创建观察者
//class Observer {
//    init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .myNotification, object: nil)
//    }
//    
//    @objc func handleNotification(_ notification: Notification) {
//        if let userInfo = notification.userInfo, let value = userInfo["key"] as? String {
//            print("Received notification with value: \(value)")
//        }
//    }
//    
//    // 发送通知的函数
//    static func sendNotification() {
//        NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: ["key": "Hello, World!"])
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//}
