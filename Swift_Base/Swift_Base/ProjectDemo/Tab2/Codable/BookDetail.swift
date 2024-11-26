//
//  BookDetail.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/26.
//

import Foundation

struct BookList: Codable {
    var list: [BookDetail] // 注意属性中所有类型也要遵守Codable协议

    /// 模型用JSONEncoder的encode转成Data
    /// JSONSerialization反序列化成Dictionary对象
    static func convertFromDict(dict: [String: Any]) -> BookList? {
        var bookList: BookList?
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: [])
            let decoder = JSONDecoder()
            bookList = try decoder.decode(BookList.self, from: data)
            print("Success:", bookList as Any)
        } catch {
            print("Error:", error)
        }
        return bookList
    }

    ///
    /// 编码（Model -> JSON Data）：
    /// let jsonData = JSONEncoder().encode(user)

    func convertToDict() -> NSDictionary? {
        var dict: NSDictionary?
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
        } catch {
            print(error)
        }
        return dict
    }
}

struct BookDetail: Codable {
    var num: Int
    var name: String
    var desc: String
    /// 字典转模型
    static func convertFromDict(dict: [String: Any]) -> BookDetail? {
        var bookDetail: BookDetail?
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: [])
            /// 解码（JSON Data -> Model）：
            /// let bookDetail = JSONDecoder().decode(BookDetail.self, from: jsonData)
            let decoder = JSONDecoder()
            bookDetail = try decoder.decode(BookDetail.self, from: data)
            print("Success:", bookDetail as Any)
        } catch {
            print("Error:", error)
        }
        return bookDetail
    }

    /// 模型转字典
    /// 编码（Model -> JSON Data）：
    /// let jsonData = JSONEncoder().encode(user)

    func convertToDict() -> NSDictionary? {
        var dict: NSDictionary?
        do {
            /// 编码（Model -> JSON Data）：
            /// let jsonData = JSONEncoder().encode(self)
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
        } catch {
            print(error)
        }
        return dict
    }
}

//protocol CodableCustom {
////    associatedtype CodableType // 关联类型
//}
//extension CodableCustom {
//    static var ws: BookList<Self>.Type {
//        get { BookList<Self>.self }
//        set {}
//    }

//    static func convertFromDict(dict: [String: Any]) -> BookList? {
//        var bookList: BookList?
//        do {
//            let data = try JSONSerialization.data(withJSONObject: dict, options: [])
//            let decoder = JSONDecoder()
//            bookList = try decoder.decode(BookList.self, from: data)
//            print("Success:", bookList as Any)
//        } catch {
//            print("Error:", error)
//        }
//        return bookList
//    }
//
//    ///
//    /// 编码（Model -> JSON Data）：
//    /// let jsonData = JSONEncoder().encode(user)
//
//    func convertToDict() -> NSDictionary? {
//        var dict: NSDictionary?
//        do {
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(self)
//            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
//        } catch {
//            print(error)
//        }
//        return dict
//    }
//    
//}
