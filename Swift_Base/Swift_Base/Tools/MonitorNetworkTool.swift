//
//  MonitorNetworkTool.swift
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
    /// WIFI网络
    case ethernetOrWiFi
}

class AlamofireMonitorNetworkTool {
    static let shared = AlamofireMonitorNetworkTool()
    
    static let networkManager = NetworkReachabilityManager(host: "www.baidu.com")
    /// 实时监听网络变化 - Alamofire
    static func monitorNetworkStatusWithAlamofire(status: @escaping (NetworkStatus)->Void) {
        networkManager!.listener = {
            alamofireStatus in
            var message = ""
            switch alamofireStatus {
            case .unknown:
                message = "未知网络"
                status(.unknown)
            case .notReachable:
                message = "无网络连接"
                status(.notReachable)
            case .reachable(.wwan):
                message = "蜂窝移动网络"
                status(.wwan)
            case .reachable(.ethernetOrWiFi):
                message = "WiFi"
                status(.ethernetOrWiFi)
            }
            mLog("当前网络状态：\(message)")
        }
        networkManager!.startListening()
    }
    // 判断网络是否连接
    static func isNetwork() -> Bool {
        return networkManager?.isReachable ?? true // 无返回就默认网络已连接
    }


}
class ReachabilityMonitorNetworkTool {
    static let shared = ReachabilityMonitorNetworkTool()
    static let reachability = try! Reachability()
    /// 实时监听网络变化 - Reachability
    static func monitorNetworkStatusWithReachability(status: @escaping (NetworkStatus)->Void) {
        // 网络可用或切换网络类型时执行
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                // print("WiFi")
                status(.ethernetOrWiFi)
            } else {
                // print("蜂窝移动网络")
                status(.wwan)
            }
        }

        // 网络不可用时执行
        reachability.whenUnreachable = { _ in
            // print("无网络连接")
            status(.notReachable)
        }

        do {
            // 开始监听，停止监听调用reachability.stopNotifier()即可
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
