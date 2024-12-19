//
//  DeviceInfo.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit

// MARK: - Class 1

// 本类仅支持iOS11,屏幕适配使用FrameMacro处理

// MARK: - 设备数据

public typealias DEV_INFO = DeviceInfo

let DEV_Application = UIApplication.shared
let DEV_KeyWindow = UIApplication.shared.keyWindow
let DEV_AppDelegate = UIApplication.shared.delegate
let DEV_UserDefaults = UserDefaults.standard
let DEV_NotificationCenter = NotificationCenter.default

/// 常用系统信息相关方法
@objcMembers

public class DeviceInfo: NSObject {
    // App 显示名称
    static let appDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] ?? ""

    // 项目/app 的名字
    static let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] ?? ""

    // App BuildNumber , 获取app的 Build ID
    static let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) ?? ""

    // Bundle Identifier ,App BundleID,获取app的 Bundle Identifier
    static let bundleIdentifier: String = Bundle.main.bundleIdentifier ?? ""

    // 设备udid
    static let identifierNumber = UIDevice.current.identifierForVendor?.uuidString ?? ""

    // App版本号
    static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

    // iOS版本
    static let iOSVersion: String = UIDevice.current.systemVersion

    // App Language en
    static let aPPLanguage = NSLocale.preferredLanguages[0]

    // MARK: - Device Info

    /// app版本号
    public static var versionS: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    // bundle id
    public static let identifier = Bundle.main.bundleIdentifier

    /// 设备名称
    public static var deviceName: String {
        return UIDevice.current.localizedModel
    }

    /// 当前系统版本
    public static var systemVersion: String {
        return UIDevice.current.systemVersion
    }

    /// APP汇总信息
    public static func deviceInfo() -> [String: String] {
        return [
            "OSVersion": appVersion,
            "OSName": osName(),
            "OSIdentifier": identifierNumber,
            "APPName": getAppName(),
            "AppVersion": appVersion,
        ]
    }

    /// App命名空间
    /*
     static var namespace: String {
         guard let namespace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else { return "" }
         return namespace
     }
     */

    /// 获取APP名称
    public static func getAppName() -> String {
        if let name = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return name
        }

        if let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            return name
        }

        if let name = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            return name
        }
        return "App"
    }

    /// 设备具体详细的型号
    public static func osName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let deviceId = machineMirror.children.reduce("") { deviceId, element in
            guard let value = element.value as? Int8, value != 0 else {
                return deviceId
            }
            return deviceId + String(UnicodeScalar(UInt8(value)))
        }

        let deviceName = deviceToName(identifier: deviceId)
        if deviceName.count > 0 {
            return deviceName
        }

        if deviceId.hasPrefix("iPhone") {
            return "iPhone"
        } else if deviceId.hasPrefix("iPad") {
            return "iPad"
        } else if deviceId.hasPrefix("iPod") {
            return "iPod Touch"
        } else if deviceId.hasPrefix("AppleTV") {
            return "Apple TV"
        }

        return "Unknown"
    }

    // MARK: - UI

    public static var isSupportSafeArea: Bool {
        if #available(iOS 11, *) {
            return true
        }
        return false
    }

//    public static func scaleW(_ width: CGFloat, fit: CGFloat = 375.0) -> CGFloat {
//        return w / fit * width
//    }
//
//    public static func scaleH(_ height: CGFloat, fit: CGFloat = 812.0) -> CGFloat {
//        return h / fit * height
//    }

//    public static func scale(_ value: CGFloat) -> CGFloat {
//        return scaleW(value)
//    }

    // MARK: - Private

    /// 获取设备标识与名称对应关系，当前值支持手机系统
    /// 设备更新信息参考：
    /// 官方文档https://developer.apple.com/design/human-interface-guidelines/layout#device-screen-sizes-and-orientations
    /// https://blog.csdn.net/qq_19926599/article/details/86747401
    /// https://www.theiphonewiki.com/wiki/Models
    private static func deviceToName(identifier: String) -> String {
        switch identifier {
        // iPhone
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"

        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1", "iPhone9,3": return "iPhone 7"
        case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"

        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"

        case "iPhone10,3", "iPhone10,6": return "iPhone X"

        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
        case "iPhone11,8": return "iPhone XR"

        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone12,8": return "iPhone SE"

        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12  Pro"
        case "iPhone13,4": return "iPhone 12  Pro Max"

        case "iPhone14,4": return "iPhone 13 mini"
        case "iPhone14,5": return "iPhone 13"
        case "iPhone14,2": return "iPhone 13  Pro"
        case "iPhone14,3": return "iPhone 13  Pro Max"
        case "iPhone14,6": return "iPhone SE"

        case "iPhone14,7": return "iPhone 14"
        case "iPhone14,8": return "iPhone 14 Plus"
        case "iPhone15,2": return "iPhone 14 Pro"
        case "iPhone15,3": return "iPhone 14 Pro Max"

        // 模拟器
        case "i386", "x86_64": return "iPhone Simulator"
        default: return ""
        }
    }
}

// MARK: - Class 2

// MARK: - 系统版本

/// 当前系统版本
let RD_iOS_SYSTEM_VERSION = (UIDevice.current.systemVersion as NSString).doubleValue

/// 系统版本大于等于
func RD_iOS_Later(_ version: Double) -> Bool {
    return RD_iOS_SYSTEM_VERSION >= version
}

/// iOS9 及更高版本
let RD_iOS9_Later = (RD_iOS_SYSTEM_VERSION >= 9.0)
/// iOS10 及更高版本
let RD_iOS10_Later = (RD_iOS_SYSTEM_VERSION >= 10.0)
/// iOS11 及更高版本
let RD_iOS11_Later = (RD_iOS_SYSTEM_VERSION >= 11.0)
/// iOS13 及更高版本
let RD_iOS13_Later = (RD_iOS_SYSTEM_VERSION >= 13.0)
/// iOS14 及更高版本
let RD_iOS14_Later = (RD_iOS_SYSTEM_VERSION >= 14.0)
/// iOS15 及更高版本
let RD_iOS15_Later = (RD_iOS_SYSTEM_VERSION >= 15.0)

// MARK: - 机型

/// 判断当前设备是否是iPhone
let RD_Is_iPhone = (UI_USER_INTERFACE_IDIOM() == .phone)
/// 判断当前设备是否是iPad
let RD_Is_iPad = UIDevice.current.userInterfaceIdiom == .pad

/// 判断  iPhone4系列   4/4s
let RD_Is_iPhone4 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 640, height: 960), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断  iPhone5系列    5/5c/5s/SE
let RD_Is_iPhone5 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 640, height: 1136), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断  iPhone6系列   6/6s/7/8/SE2，@2x
let RD_Is_iPhone6 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 750, height: 1334), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断  iphone6Plus系列   6+/6s+/7+/8+，@3x
let RD_Is_iPhone6p = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1242, height: 2208), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断  iPhoneX 、XS 、11 Pro，@3x
let RD_Is_iPhoneX = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断  iPhoneXS
let RD_Is_iPhoneXS = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断  iPhoneXs Max、11 Pro Max，@3x
let RD_Is_iPhoneXsMax = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断  iPHoneXR、11，@2x
let RD_Is_iPhoneXR = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 828, height: 1792), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断iPhone12Mini、13Mini       @3x
let RD_Is_iPhone12Mini = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1080, height: 2340), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断iPhone12 、12Pro、13、13Pro      @3x
let RD_Is_iPhone12 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1170, height: 2532), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)
/// 判断iPhone12Pro Max、13 Pro Max     @3x
let RD_Is_iPhone12ProMax = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1284, height: 2778), (UIScreen.main.currentMode?.size)!) && !RD_Is_iPad : false)

/// 刘海屏系列
let RD_Is_IPhoneX_All = (RD_Is_iPhoneX || RD_Is_iPhoneXR || RD_Is_iPhoneXS || RD_Is_iPhoneXsMax || RD_Is_iPhone12Mini || RD_Is_iPhone12 || RD_Is_iPhone12ProMax)

/*
 // 屏幕宽度
 public static let w = UIScreen.main.bounds.width

 // 屏幕高度
 public static let h = UIScreen.main.bounds.height

 public static var window: UIWindow? {
     return UIWindow.keyWindow
 }

 public static let bounds = UIScreen.main.bounds

 // 等比适配
 public static let equalScale = w / 375

 // 状态栏高度
 public static let statusBarHeight: CGFloat = isSupportSafeArea ? (window?.safeAreaInsets.top ?? 20) : 20

 // 底部安全区高度
 public static let bottomSafeHeight: CGFloat = isSupportSafeArea ? (window?.safeAreaInsets.bottom ?? 0) : 0

 // 导航栏高度
 public static let naviHeight: CGFloat = 44

 // TableBar高度
 public static let tableBarHeight: CGFloat = 49

 // 顶部高度
 public static let topBarHeight: CGFloat = statusBarHeight + naviHeight

 // 底部高度
 public static let bottomBarHeight: CGFloat = bottomSafeHeight + tableBarHeight
 */
