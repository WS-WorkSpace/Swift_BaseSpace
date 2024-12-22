//
//  CommonTool.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit
class CommonTool {
    /// 检测当前是否是深色模式
    static func RD_isDarkMode() -> Bool {
        if !RD_IsOpenDarkMode {
            return false
        }
        if #available(iOS 13.0, *) {
            let currentMode = UITraitCollection.current.userInterfaceStyle
            if currentMode == .dark {
                return true
            }
        }
        return false
    }
}
