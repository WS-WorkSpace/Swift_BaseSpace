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

        let str = " dsadsadsadsadsadsadsadsadsadsadsadsadsadsadasd1231231232131313212313213213213 "
        let trimmedStr = str.trimmingCharacters(in: .whitespacesAndNewlines)

        self.window?.RD_y = 100
        print(str.RD_isEmpty)
        print(str.RD_getStringHeight(100, 18))

        return true
    }

    func initWindow() {
        self.window = UIWindow()
        self.window?.backgroundColor = UIColor.white
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = RootViewController()
    }

    // MARK: UISceneSession Lifecycle
}
