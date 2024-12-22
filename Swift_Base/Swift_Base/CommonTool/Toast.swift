//
//  Toast.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/29.
//

import Foundation
import Toast_Swift

@objcMembers class Toast: NSObject {
    /// 全场toast
    public static var window: UIWindow? {
        return UIWindow.keyWindow
    }

    public static func toast(_ message: String, position: ToastPosition = .center) {
        // UIWindow.keyWindow?.view.toast(message: message)
        window?.makeToast(message, duration: 2.0, position: position)
    }

    public static func toast(_ message: String, position: ToastPosition = .center, duration: Double) {
        // UIWindow.keyWindow?.view.toast(message: message)
        window?.makeToast(message, duration: duration, position: position)
    }
    public static func runTempForOC(_ message: String) {
        window?.makeToast(message, duration: 2.0)
    }

}

