//
//  String+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit

/// 字符串取类型的长度
public enum StringTypeLength {
    /// Unicode字符个数
    case count
    /// utf8
    case utf8
    /// utf16获取长度对应NSString的.length方法
    case utf16
    /// unicodeScalars
    case unicodeScalars
    /// utf8编码通过字节判断长度
    case lengthOfBytesUtf8
    /// 英文 = 1，数字 = 1，汉语 = 2
    case customCountOfChars
}
extension String {
    // MARK: 1.1、字符串的长度
    /// 字符串的长度
    var length: Int {
        return self.count
    }
    
    // MARK: 1.2、字符串取类型的长度
    /// 字符串取类型的长度
    func typeLengh(_ type: StringTypeLength) -> Int {
        let string = self
        if type == .utf8 {
            return string.utf8.count
        } else if type == .utf16 {
            return string.utf16.count
        } else if type == .unicodeScalars {
            return string.unicodeScalars.count
        } else if type == .lengthOfBytesUtf8 {
            return string.lengthOfBytes(using: .utf8)
        }  else if type == .customCountOfChars {
            return string.jk.customCountOfChars()
        }
        return string.count
    }
    
    // MARK: 1.2、判断是否包含某个子串
    /// 判断是否包含某个子串
    /// - Parameter find: 子串
    /// - Returns: Bool
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    // MARK: 1.3、判断是否包含某个子串 -- 忽略大小写
    ///  判断是否包含某个子串 -- 忽略大小写
    /// - Parameter find: 子串
    /// - Returns: Bool
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    

}

extension String {
    
    /// 字符串转 base64
    var base64Encode: String? {
        guard let codingData = self.data(using: .utf8) else {
            return nil
        }
        return codingData.base64EncodedString()
    }
    /// base64转字符串转
    var base64Decode: String? {
        guard let decryptionData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return String(data: decryptionData, encoding: .utf8)
    }
    // MARK: JSON 字符串 ->  Dictionary
    /// JSON 字符串 ->  Dictionary
    /// - Returns: Dictionary
    func jsonStringToDictionary() -> Dictionary<String, Any>? {
        let jsonString = self
        guard let jsonData: Data = jsonString.data(using: .utf8) else { return nil }
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return (dict as! Dictionary<String, Any>)
        }
        return nil
    }
    
    // MARK: JSON 字符串 -> Array
    /// JSON 字符串 ->  Array
    /// - Returns: Array
    func jsonStringToArray() -> Array<Any>? {
        let jsonString = self
        guard let jsonData: Data = jsonString.data(using: .utf8) else { return nil }
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return (array as! Array<Any>)
        }
        return nil
    }

    
}
extension String {
    /// 判空
    public var RD_isEmpty: Bool {
        // 字符串的开头和结尾删除空格，请执行以下操作
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }

    /// 一串字符在固定宽度下，正常显示所需要的高度
    func RD_getStringHeight(_ width: CGFloat, _ font: CGFloat) -> CGFloat {
        let size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
        return size.height
    }

    /// 一串字符在一行中正常显示所需要的宽度
    func RD_getStringWidth(_ font: CGFloat) -> CGFloat {
        let size = self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
        return size.width
    }
}
