//
//  AppDelegate.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/29.
//

import SnapKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initWindow()
        monitorNetwork2()
        self.getAppInfo()
        #if DEBUG
        let fpsLab = FPSLabel(frame: CGRectMake(100, 100, 150, 50))
        self.window?.addSubview(fpsLab)
        fpsLab.snp.makeConstraints { make in
            make.top.equalTo(self.window!).offset(distanceTop)
            make.left.equalTo(self.window!).offset(10)
            make.size.equalTo(CGSizeMake(70, 30))
        }
        #endif
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
//        print("App 显示名称 :", DEV_INFO.appDisplayName)
//        print("App BundleName :", DEV_INFO.appName)
//        print("App BuildNumber :", DEV_INFO.build)
//        print("Bundle Identifier :", DEV_INFO.bundleIdentifier)
//        print("设备udid :", DEV_INFO.identifierNumber)
//        print("App 版本号 :", DEV_INFO.appVersion)
//        print("iOS版本 :", DEV_INFO.iOSVersion)
        print("App Language :", DEV_INFO.aPPLanguage)
    }

    // MARK: UISceneSession Lifecycle
}
