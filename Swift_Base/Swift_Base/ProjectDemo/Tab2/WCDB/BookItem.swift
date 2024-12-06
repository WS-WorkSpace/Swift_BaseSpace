//
//  Book.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/5.
//

import UIKit
import WCDBSwift

final class BookItem: NSObject, TableCodable {
    /// 作者ID
    var authorNumber: Int = 0
    /// 作者名
    var authorName: String?
    /// 简介
    var desc: String?

    enum CodingKeys: String, CodingTableKey {
        typealias Root = BookItem
        static let objectRelationalMapping = TableBinding(CodingKeys.self)

        case authorNumber
        case authorName
        case desc
    }

    /// 用于定义是否使用自增的方式插入
    var isAutoIncrement: Bool = false

    /// 用于获取自增插入后的主键值
    var lastInsertedRowID: Int64 = 0
}
