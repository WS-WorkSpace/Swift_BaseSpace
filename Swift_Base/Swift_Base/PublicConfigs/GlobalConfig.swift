//
//  GlobalConfig.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import Foundation
import UIKit

public enum GlobalConfig {
    // MARK: - Config Info

    public static let gBaseUrl = "192.168.1.177"
    // public static let gBaseUrl = "192.168.1.105"

    public static let gRpcUrl = gBaseUrl
    public static let gRestUrl = "http://\(gBaseUrl):9098/grpc"
    public static let gCharHost = "http://\(gBaseUrl):9100"

    // 高德地图key
    public static let gGaoDeMapKey = "b00c88f69a38f58eee2a00b6ebe1abda"

    // MARK: -  UI
}
