//
//  ExtensionCompatible.swift
//  WS_Networing_Swift
//
//  Created by 王爽 on 2023/7/12.
//

import Foundation

/// 前缀类型
struct WS<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

/// 利用协议扩展前缀属性
protocol WSCompatible {}
extension WSCompatible {
    static var ws: WS<Self>.Type {
        get { WS<Self>.self }
        set {}
    }

    var ws: WS<Self> {
        get { WS(self) }
        set {}
    }
}

