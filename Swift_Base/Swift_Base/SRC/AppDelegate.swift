//
//  AppDelegate.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initWindow()
        self.monitorNetwork()
        //self.getAppInfo()
        return true
    }

    func initWindow() {
        self.window = UIWindow()
        self.window?.backgroundColor = UIColor.white
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = BaseTabBarController()
    }

    func getAppInfo() {
        print("App 显示名称 :", DEV_INFO.appDisplayName)
        print("App BundleName :", DEV_INFO.appName)
        print("App BuildNumber :", DEV_INFO.build)
        print("Bundle Identifier :", DEV_INFO.bundleIdentifier)
        print("设备udid :", DEV_INFO.identifierNumber)
        print("App 版本号 :", DEV_INFO.appVersion)
        print("iOS版本 :", DEV_INFO.iOSVersion)
        print("App Language :", DEV_INFO.aPPLanguage)
    }

    // MARK: UISceneSession Lifecycle
}

extension AppDelegate {
    // MARK: - 实时网络监测

    func monitorNetwork() {
        /// 监听网络变化 - Alamofire
        self.monitorNetworkAlamofire()
        /// 判断是否有网络
        //mLog(AlamofireMonitorNetworkTool.isNetwork())
        /// 监听网络变化 - ReachabilitySwift
        /// monitorNetworkReachability()
    }

    /// 监听网络变化 - Alamofire
    func monitorNetworkAlamofire() {
        AlamofireMonitorNetworkTool.monitorNetworkStatusWithAlamofire { status in
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
            Toast.toast("Alamofire网络监控:\(message)", duration: 0.99)
        }
    }

    /// 监听网络变化 - Reachability
    func monitorNetworkReachability() {
        ReachabilityMonitorNetworkTool.monitorNetworkStatusWithReachability { status in
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
            Toast.toast("Reachability网络监控:\(message)", duration: 0.99)
        }
    }
}
