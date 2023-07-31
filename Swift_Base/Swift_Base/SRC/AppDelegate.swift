//
//  AppDelegate.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/29.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initWindow()
        monitorNetwork2()
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

    // MARK: UISceneSession Lifecycle
}
