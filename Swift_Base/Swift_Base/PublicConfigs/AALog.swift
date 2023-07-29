//
//  AALog.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/29.
//

import Foundation

public typealias Lg = Logger

@objcMembers
public class Logger: NSObject
{
    public static func log(_ items: Any...,
                           separator: String = " ",
                           terminator: String = "\n",
                           file: String = #file,
                           line: Int = #line,
                           method: String = #function)
    {
        #if DEBUG
            let formatter = DateFormatter()
            formatter.locale = Locale.current
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = formatter.string(from: Date())
            print("\(date) \((file as NSString).lastPathComponent)[\(line)],\(method)", terminator: separator)
            var i = 0
            let j = items.count
            for a in items
            {
                i += 1
                print(" ", a, terminator: i == j ? terminator : separator)
            }
        #endif
    }

    public static func AALog<T>(_ message: T)
    {
        #if DEBUG
            print("\(message)")
        #endif
    }

    private static func _log<T>(_ title: String, _ msg: T, _ file: NSString,
                                _ fn: String, _ line: Int)
    {
        #if DEBUG
            print("「 Logger 」\(title) \(file.lastPathComponent) >> \(line) >> \(fn) ：\(msg)")
        #endif
    }

    static func error<T>(_ msg: T,
                         _ file: NSString = #file,
                         _ fn: String = #function,
                         _ line: Int = #line)
    {
        _log("❌", msg, file, fn, line)
    }

    static func warnning<T>(_ msg: T,
                            _ file: NSString = #file,
                            _ fn: String = #function,
                            _ line: Int = #line)
    {
        _log("⚠️", msg, file, fn, line)
    }

    static func success<T>(_ msg: T,
                           _ file: NSString = #file,
                           _ fn: String = #function,
                           _ line: Int = #line)
    {
        _log("✔️", msg, file, fn, line)
    }

    static func info<T>(_ msg: T,
                        _ file: NSString = #file,
                        _ fn: String = #function,
                        _ line: Int = #line)
    {
        _log("✔️", msg, file, fn, line)
    }
}
