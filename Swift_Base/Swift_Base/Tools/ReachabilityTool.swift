//
//  ReachabilityTool.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import Alamofire
import Foundation
import Reachability

enum NetworkStatus {
    /// 未知网络
    case unknown
    /// 无网络
    case notReachable
    /// 手机网络
    case wwan
    // WIFI网络
    case ethernetOrWiFi
}

class ReachabilityTool {
    static let shared = ReachabilityTool()
    
    static let reachability = try! Reachability()
    static let networkManager = NetworkReachabilityManager(host: "www.baidu.com")
    
    /// 监听网络变化 - ReachabilitySwift
    static func monitorNetworkStatus1(status: @escaping (NetworkStatus)->Void) {
        // 网络可用或切换网络类型时执行
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                Lg.info("WiFi")
                status(.ethernetOrWiFi)
            } else {
                Lg.info("蜂窝移动网络")
                status(.wwan)
            }
        }
        
        // 网络不可用时执行
        reachability.whenUnreachable = { _ in
            Lg.info("无网络连接")
            status(.notReachable)
        }
        
        do {
            // 开始监听，停止监听调用reachability.stopNotifier()即可
            try reachability.startNotifier()
        } catch {
            Lg.info("Unable to start notifier")
        }
    }
    
    /// 监听网络变化 - Alamofire
    static func monitorNetworkStatus2(status: @escaping (NetworkStatus)->Void) {
        networkManager!.listener = {
            status in
            var message = ""
            switch status {
            case .unknown:
                message = "未知网络"
            case .notReachable:
                message = "无网络连接"
            case .reachable(.wwan):
                message = "蜂窝移动网络"
            case .reachable(.ethernetOrWiFi):
                message = "WiFi"
            }
            Lg.info("当前网络状态：\(message)")
        }
        networkManager!.startListening()
    }
}
