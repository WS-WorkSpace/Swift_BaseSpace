//
//  Car.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/16.
//

import UIKit

// Swift要暴漏给OC的类,最终要继承于 NSObject
// @objcMembers 等于所有成员以及扩展,都 @objc,暴漏给OC

//可以通过 @objc 重命名Swift暴露给OC的符号名（类名、属性名、函数名等）
@objc(WS_Car)
@objcMembers class Car: NSObject {
    var price: Double
    @objc(name)
    var band: String
    init(price: Double, band: String) {
        self.price = price
        self.band = band
    }
    @objc(ws_run)
    func run() {
        print(price, band, "run")
    }

    static func run() { print("Car run") }
}

extension Car {
//    @objc(exec:v2:)
    func test() { print(price, band, "test") }
}
