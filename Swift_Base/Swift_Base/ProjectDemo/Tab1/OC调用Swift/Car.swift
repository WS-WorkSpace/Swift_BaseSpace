//
//  Car.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/16.
//

import UIKit

//Swift要暴漏给OC的类,最终要继承于 NSObject
//@objcMembers 等于所有成员以及扩展,都 @objc,暴漏给OC
@objcMembers class Car: NSObject {
    var price: Double
    var band: String
    init(price: Double, band: String) {
        self.price = price
        self.band = band
    }
    func run() {
        print(price, band, "run")
    }
    static func run() { print("Car run") }
}
extension Car {
    func test() { print(price, band, "test") }
}
