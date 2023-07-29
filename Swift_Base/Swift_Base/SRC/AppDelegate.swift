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
        let num = 10
        Logger.log("打撒打撒",num)
        Toast.toast("--->myPro")
        return true
    }

    func initWindow() {
        // 创建窗口
        self.window = UIWindow()
        self.window?.backgroundColor = UIColor.white
        self.window?.frame = UIScreen.main.bounds
        // 显示窗口
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = RootViewController()
    }

    // MARK: UISceneSession Lifecycle
}
