//
//  ExampleIetm.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/5.
//

import UIKit
import WCDBSwift

/*
 * 模型绑定可参照SampleORM，模型绑定类型可为class，struct，enum
 *
 * 字段映射的类型，并非所有类型的变量都支持被绑定为字段。WCDB Swift 内建了常用类型的支持，包括：
 * 32 位整型    Bool, Int, Int8, Int16, Int32, UInt, UInt8, UInt16, UInt32
 * 64 位整型    Int64, UInt64, Date
 * 浮点型    Float, Double
 * 字符串类型    String, URL
 * 二进制类型    Data, Array, Dictionary, Set
 * 其中 Date 以时间戳的形式存储, Array、Dictionary、Set 以 JSON 的形式存储。
 * 对于没有内建支持的类型，可以手动为其添加支持，参照Customer
 *
 */

final class ExampleItem: TableCodable {
    // 模型绑定类型最好都设置为可选值，不然部分查询容易出错
//    var identifier: Int? = nil
    /// 作者ID
    var authorNumber: Int? = nil
    /// 作者名
    var authorName: String?
    /// 简介
    var desc: String?
    /// 不需要写入数据库的数据
    var descTemp: String?

//    var myClass: Customer? = nil

    // 这一块管WCDB在数据库需要存储的值
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ExampleItem
        // 对于变量名与表的字段名不一样的情况，可以使用别名进行映射
        // 对于不需要写入数据库的字段，则不需要在 CodingKeys 内定义,比如descTemp
        case authorNumber = "id"
        case authorName
        case desc

        // 这一块是配置数据库存储值的设定
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            /*
             * BindColumnConstraint(
             * _ codingKey: CodingTableKeyType,// 对应字段的枚举
             * isPrimary: Bool = false, // 该字段是否为主键。字段约束中只能同时存在一个主键
             * orderBy term: OrderTerm? = nil, // 当该字段是主键时，存储顺序是升序还是降序
             * isAutoIncrement: Bool = false, // 当该字段是主键时，其是否支持自增。只有整型数据可以定义为自增。
             * onConflict conflict: Conflict? = nil, // 当该字段是主键时，若产生冲突，应如何处理
             * isNotNull: Bool = false, // 该字段是否可以为空
             * isUnique: Bool = false, // 该字段是否可以具有唯一性
             * defaultTo defaultValue: ColumnDef.DefaultType? = nil // 该字段在数据库内使用什么默认值)
             */

            // 设置列的配置，WCDB里表主键只能设置一个
            BindColumnConstraint(authorNumber, isPrimary: true)
            BindColumnConstraint(authorNumber, isNotNull: true, defaultTo: "defaultDescription")
            BindColumnConstraint(authorNumber, isAutoIncrement: true)


            /*
                         //设置索引，索引名为表名+subfix（即这儿_uniqueIndex）, isUnique：是否唯一（唯一索引就是字段的值不能有重复的两行出现）
                         //列同时为主键和列的唯一索引，主键优先级大于唯一索引
                         BindIndex(identifier, namedWith: "_uniqueIndex",isUnique: true)
                         //对于需要特别指明索引存储顺序的字段，可以通过 asIndex(orderBy:) 函数指定
                         BindIndex(description.asIndex(orderBy: .descending), namedWith: "_descendingIndex")
                         //对于由多个字段组成的联合索引，BindIndex后面可以指定多个字段
                         BindIndex(identifier, description.asIndex(orderBy: .descending), namedWith: "_multiIndex")
                         //联合主键约束
             //            BindMultiPrimary(multiUniquePart1,multiUniquePart2.asIndex(orderBy: .descending))
                         //联合唯一约束
             //            BindMultiUnique(multiUniquePart1,multiUniquePart2)
                         //检查约束，有此约束，必须满足里面条件的数据才可插入，否则报错
             //            BindChecks {
             //                multiUniquePart2 > 3
             //            }
                         //设置两表的联合外键，用于联表查询
                         //点击了"可中断事务"后会有sampleTable，然后可以使用以下sql语句查询
                         //select sampleTable.id as sample_id, sampleTable.description as sample_des from sampleTable join Sample on Sample.id = sampleTable.id
             //            BindForeginKey(identifier, foreignKey: ForeignKey.init().references(with: "sampleTable").columns(Sample.Properties.identifier))
                         */
        }
    }

    // 当主键需要自动递增时需设置下面两个属性
    // 用于定义是否使用自增的方式插入
    var isAutoIncrement: Bool = true // 这儿一定要设置为false，设置了初始值false一样递增，若是设置了true当插入相同主键时，会crash
    // 用于获取自增插入后的主键值
    var lastInsertedRowID: Int64 = 0
}
