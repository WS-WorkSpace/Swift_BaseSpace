//
//  WS_Cache.swift
//  WS_Networing_Swift
//
//  Created by 王爽 on 2023/7/10.
//

import Foundation

public struct WS_Cache {
    private static var data = [String: Any]()
    //gcd信号量可以同时一条线程访问
    private static var lock = DispatchSemaphore(value: 1)
//    private static var lock1 = NSLock()
//    递归调用使用lock1会死锁,使用递归锁NSRecursiveLock
//    private static var lock2 = NSRecursiveLock()

    static func get(_ key: String) -> Any? {
        data[key]
    }
    static func set(_ key: String, _ value: Any) {
        lock.wait()
        defer { lock.signal() }
//        lock1.lock()
//        defer { lock1.unlock() }
//        lock2.lock()
//        defer { lock2.unlock() }

        data[key] = value
    }
}
