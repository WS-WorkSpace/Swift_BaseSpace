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

/// 给String.ws. String().ws前缀扩展功能
extension WS where Base == String {
    var numCount: Int {
        var count = 0
        for c in base where ("0" ... "9").contains(c) {
            count += 1
            print(c)
        }
        return count
    }

    func addPrefix(_ prefix: String) -> String {
        print(self) // WS<String>(base: "Jack")
        print(base) // Jack
        return prefix + base
    }

    // mutating 表示有可能修改WS这个结构体里面内容,希望WS是可变的可修改的
    // ws是只读的计算属性
    mutating func run() {}

    static func test() {
        print("类方法扩展示例")
    }
}
