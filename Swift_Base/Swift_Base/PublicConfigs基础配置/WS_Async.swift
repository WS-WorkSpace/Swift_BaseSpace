//
//  WS_Async.swift
//  WS_Networing_Swift
//
//  Created by 王爽 on 2023/7/10.
//

import Foundation

public typealias S_Task = () -> Void
public struct WS_Async {
    public static func async(_ task: @escaping S_Task) {
        _async(task)
    }
    public static func async(_ task: @escaping S_Task,
                             _ mainTask: @escaping S_Task) {
        _async(task, mainTask)
    }
    private static func _async(_ task: @escaping S_Task,
                               _ mainTask: S_Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    //MARK: -同步延迟执行
    @discardableResult
    public static func delay(_ seconds: Double,
                             _ block: @escaping S_Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds,
                                      execute: item)
        return item
    }
    //MARK: -异步延迟执行
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping S_Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task)
    }
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping S_Task,
                                  _ mainTask: @escaping S_Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task, mainTask)
    }
    private static func _asyncDelay(_ seconds: Double,
                                    _ task: @escaping S_Task,
                                    _ mainTask: S_Task? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds,
                                          execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
    //MARK: -once

}

