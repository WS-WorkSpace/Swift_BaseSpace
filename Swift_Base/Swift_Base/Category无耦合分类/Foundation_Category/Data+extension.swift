//
//  Data+extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/19.
//

import Foundation

// MARK: - 一、基本的扩展
public extension Data {

    // MARK: 1.1、base64编码成 Data
    /// 编码
    var encodeToData: Data? {
        return self.base64EncodedData()
    }
    
    // MARK: 1.2、base64解码成 Data
    /// 解码成 Data
    var decodeToDada: Data? {
        return Data(base64Encoded: self)
    }
    
    // MARK: 1.3、转成bytes
    /// 转成bytes
    var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    // MARK: 1.4、Data转十六进制的字符串
    /// Data转16进制的字符串
    /// - Parameter data: data
    /// - Returns: 16进制的字符串
    var toHexString: String? {
        let data = self
        let dataBuffer = [UInt8](data)
        let dataLength = data.count
        var hexString = ""
        
        for i in 0..<dataLength {
            hexString += String(format: "%02lx", dataBuffer[i])
        }
        
        return hexString
    }
}
