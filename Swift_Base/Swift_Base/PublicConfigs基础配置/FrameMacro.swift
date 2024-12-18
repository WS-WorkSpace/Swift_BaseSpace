//
//  FrameMacro.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit

// MARK: - 固定高度

/// 屏幕宽度
let kScreenWidth = UIScreen.main.bounds.width
/// 屏幕高度
let kScreenHeight = UIScreen.main.bounds.height
/// 导航条高度
let kNaviHeight = 44.0
/// TableBar高度
let kTableBarHeight = 49.0

// MARK: - 计算使用高度

/// 顶部高度 = 顶部状态栏高度 + 导航条高度
let distanceTop = (kStatusBarHeight + kNaviHeight)
/// 底部高度 = Tabbar高度 + 底部高度
let distanceBottom = (49.0 + kBottomSafeHeight)
/// table/collection 高度 = 当前屏幕高度 - (顶部状态栏高度 + 导航条高度44) - 底部高度34
let kScrollViewHeight = kScreenHeight-distanceTop-kBottomSafeHeight
let kScrollViewFrame = CGRect(x: 0, y: distanceTop, width: kScreenWidth, height: kScrollViewHeight)
/// 按照 iphoneX 比例缩放
let kWidthRatio = (kScreenWidth / 375.0)
let kHeightRatio = (kScreenHeight / 812.0)
func RD_Ratio(_ value: CGFloat) -> CGFloat {
    return kScreenWidth * (value / 375.0)
}

// MARK: - 方法获取高度

/** 顶部状态栏高度（包括安全区5px） **/
/// 状态栏高度。非刘海屏20，X是44，11是48，
/// SE1/SE2 = 20
/// 10x/10xs/10xsMax/10xR/11/11pro/11proMax = 44
/// 12mini/13mini = 50 ,
/// 12/12pro/12proMax/13/13pro/13proMax/14/14plus = 47,
/// 14pro/14proMax = 54
let kStatusBarHeight = STATUSBAR_HEIGHT()
/// 安全区域高度 != 状态栏高度,因为在ipple 14 PRO && iOS 13以上的情况下,状态栏高度54,安全区高度59
let kTopSafeHeight = SAFEAREA_TOP()
/// let safeAreaInsets_top: CGFloat = (1 == 1) ? (getWindow()?.safeAreaInsets.top ?? 20) : 20
/// 34 || 0
let kBottomSafeHeight = SAFEAREA_BOTTOM()

// MARK: -获取statusBar状态栏的高度
func STATUSBAR_HEIGHT() -> CGFloat {
    /*
    if #available(iOS 11.0, *) {
            return getWindow()?.safeAreaInsets.top ?? 0
        }
    */
    if #available(iOS 13.0, *) {
        let window: UIWindow? = UIApplication.shared.windows.first
        let statusBarHeight = (window?.windowScene?.statusBarManager?.statusBarFrame.height) ?? 0
        return statusBarHeight
        /*
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = scene as? UIWindowScene else { return 0 }
        guard let statusBarManager = windowScene.statusBarManager else { return 0 }
        return statusBarManager.statusBarFrame.height
         */
    }
    else {
        // 防止界面没有出来获取为0的情况
        return UIApplication.shared.statusBarFrame.height > 0 ? UIApplication.shared.statusBarFrame.height : 44
    }
}
// MARK: 2.4、顶部安全区高度
/// 2.4、顶部安全区高度
func SAFEAREA_TOP() -> CGFloat {
    if #available(iOS 13.0, *) {
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = scene as? UIWindowScene else { return 0 }
        guard let window = windowScene.windows.first else { return 0 }
        return window.safeAreaInsets.top
    }
    return 0
}
// MARK: 2.6、底部安全区高度
/// 底部指示条高度
func SAFEAREA_BOTTOM() -> CGFloat {
    if #available(iOS 11.0, *) {
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = scene as? UIWindowScene else { return 0 }
        guard let window = windowScene.windows.first else { return 0 }
        return window.safeAreaInsets.bottom
    }
    return 0
}

// MARK: 2.9、身份证宽高比
public let kRatioIDCard: CGFloat = 0.63


/// 获取当前设备window用于判断尺寸
//func getWindow() -> UIWindow? {
//    var originalKeyWindow: UIWindow?
//    #if swift(>=5.1)
//        if #available(iOS 13, *) {
//            originalKeyWindow = UIApplication.shared.connectedScenes
//                .compactMap { $0 as? UIWindowScene }
//                .flatMap { $0.windows }
//                .first(where: { $0.isKeyWindow })
//        } else {
//            originalKeyWindow = UIApplication.shared.keyWindow
//        }
//    #else
//        originalKeyWindow = UIApplication.shared.keyWindow
//    #endif
//    return originalKeyWindow
//}

// func getWindow() -> UIWindow? {
//    if #available(iOS 13.0, *) {
//        let winScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//        return winScene?.windows.first
//    } else {
//        return UIApplication.shared.keyWindow
//    }
// }
