//
//  AppDelegate+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import IQKeyboardManagerSwift
import UIKit

extension AppDelegate {
    // MARK: - 键盘处理

    func AppDelegate_configIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true // 工具条
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true // 点击背景收回键盘
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        //        IQKeyboardManager.shared.preventShowingBottomBlankSpace = true
        //        IQKeyboardManager.shared.preventShowingBottomBlankSpace = false
        IQKeyboardManager.shared.toolbarTintColor = .lightGray
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 5.0
    }

    // MARK: - 实时网络监测

    func monitorNetwork1() {
        ReachabilityTool.monitorNetworkStatus1 { status in
            var message = ""
            switch status {
            case .unknown:
                message = "未知网络"
            case .notReachable:
                message = "无网络连接"
            case .wwan:
                message = "蜂窝移动网络"
            case .ethernetOrWiFi:
                message = "WiFi"
            }
//            RDProgressHUD.showText(message)
        }
    }

    func monitorNetwork2() {
        ReachabilityTool.monitorNetworkStatus2 { status in
            print("-----", status)
        }
    }
}
