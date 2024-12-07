//
//  WCDManager.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/4.
//

import UIKit
import WCDBSwift

/// 设置表名称
enum DBTableName: String {
    case bookTable = "BookItem"
    case addressTable = "AddressModel"
}

public let MYDB = DBManager.shared

public class DBManager: NSObject {
    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/myWCDB.db")
    static let shared: DBManager = .init()
    public var db: Database!

    private func createDB() -> Database {
        let db = Database(at: path)
        print("创建数据库:", path)
        return db
    }

    override private init() {
        super.init()
        db = createDB()
         // 全局性能监控
         Database.globalTracePerformance { tag, path, handleId, sql, cost in
             //print("WCDB数据库性能指标： tag \(tag) id \(handleId) at path \(path) takes \(cost) seconds to execute sql \(sql)")
         }

         // 全局错误监控
         Database.globalTraceError { (error: WCDBError) in
             #if DEBUG
             assert(error.level != .Fatal)
             #endif

             if error.level == .Ignore {
                 // print("可忽略WCDB数据库信息", error)
             } else {
                 // print("WCDB数据库错误", error)
             }
         }
        db.setNotification { corruptedDatabase in
            print("Database is corrupted: tag \(corruptedDatabase.tag ?? 0), path \(corruptedDatabase.path)")
            // WCDB 检测到损坏之后，isAlreadyCorrupted会始终返回 YES
            print("WCDB数据库有损坏", corruptedDatabase.isAlreadyCorrupted()) // 输出1
        }
    }

//    private func createTable() {
//        do {
//            // 1. 创建主数据库main的相关表
//            try db?.run(transaction: {
//                createTable(name: (DBTableName.bookTable.rawValue), model: Book.self)
    ////                createTable(table: DBTableName.addressTable, modelType: AddressModel.self)
//            })
//
//        } catch {
//            print("初始化数据库及ORM对应关系建立失败\(error.localizedDescription)")
//        }
//    }

    // MARK: - 创建表

    public func createTable<T: TableCodable>(name: String? = nil, model: T.Type) {
        do {
            try db.create(table: name ?? "\(T.self)", of: T.self)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    //    private func createTable<T: TableDecodable>(table: DBTableName, modelType: T.Type) {
    //        do {
    //            try db?.create(table: table.rawValue, of: modelType)
    //        }catch let error {
    //            debugPrint(error.localizedDescription)
    //        }
    //    }

    // MARK: - 增

    // 只是单纯的插入数据,主键冲突可能会失败
    // 传入多参数
    public func insert<T: TableEncodable>(objects: T..., intoTable tableName: String) {
        do {
            try db?.insert(objects, intoTable: tableName)

        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    // 传入数组
    public func insert<T: TableEncodable>(objects: [T], intoTable tableName: String) {
        do {
            try db?.insert(objects, intoTable: tableName)

        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    /// 插入数据，当数据出现冲突时会失败，而后两个在主键冲突等约束冲突出现时，insertOrReplace会把新数据会覆盖旧数据
    public func insertOrReplace<T: TableCodable>(_ objects: T..., tableName: String? = nil, on propertyConvertibleList: [PropertyConvertible]? = nil) {
        let table = db.getTable(named: tableName ?? "\(T.self)", of: T.self)
        do {
            try table.insertOrReplace(objects, on: propertyConvertibleList)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    public func insertOrReplace<T: TableCodable>(_ objects: [T], tableName: String? = nil, on propertyConvertibleList: [PropertyConvertible]? = nil) {
        let table = db.getTable(named: tableName ?? "\(T.self)", of: T.self)
        do {
            try table.insertOrReplace(objects, on: propertyConvertibleList)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }


    /// 对特定（或全部）属性执行插入或忽略‘ tableencoable ’对象。///如果当前表中已经存在相同的主键或行id，则忽略该对象。
    /// insertOrIgnore则是会忽略冲突数据，而不产生错误。
    public func insertOrIgnore<T: TableCodable>(_ objects: T..., tableName: String? = nil, on propertyConvertibleList: [PropertyConvertible]? = nil) {
        let table = db.getTable(named: tableName ?? "\(T.self)", of: T.self)
        do {
            try table.insertOrIgnore(objects, on: propertyConvertibleList)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    // MARK: - 删

    public func delete<T: TableCodable>(_ model: T.Type,
                                        tableName: String? = nil,
                                        where condition: Condition? = nil,
                                        orderBy orderList: [OrderBy]? = nil,
                                        limit: Limit? = nil,
                                        offset: Offset? = nil)
    {
        let table = db.getTable(named: tableName ?? "\(model.self)", of: model.self)
        do {
            try table.delete(where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

//    ///删除
//    public func deleteFromDb(fromTable table: DBTableName, where condition: Condition? = nil){
//        do {
//            try db?.delete(fromTable: table.rawValue, where:condition)
//        } catch let error {
//            debugPrint("delete error \(error.localizedDescription)")
//        }
//    }

    // MARK: - 改

    public func update<T: TableCodable>(tableName: String? = nil,
                                        on propertyConvertibleList: PropertyConvertible...,
                                        with object: T,
                                        where condition: Condition? = nil,
                                        orderBy orderList: [OrderBy]? = nil,
                                        limit: Limit? = nil,
                                        offset: Offset? = nil)
    {
        let table = db.getTable(named: tableName ?? "\(T.self)", of: T.self)
        do {
            try table.update(on: propertyConvertibleList, with: object, where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

//    ///修改
//    public func update<T: TableEncodable>(fromTable table: DBTableName, on propertys:[PropertyConvertible], itemModel object:T,where condition: Condition? = nil){
//        do {
//            print(object)
//            try db?.update(table: table.rawValue, on: propertys, with: object, where: condition)
//        } catch let error {
//            debugPrint(" update obj error \(error.localizedDescription)")
//        }
//    }

    // MARK: - 查

    public func getObjects<T: TableCodable>(_ model: T.Type,
                                            tableName: String? = nil,
                                            where condition: Condition? = nil,
                                            orderBy orderList: [OrderBy]? = nil,
                                            limit: Limit? = nil,
                                            offset: Offset? = nil) -> [T]
    {
        let table = db.getTable(named: tableName ?? "\(model.self)", of: model.self)
        do {
            let objects: [T] = try table.getObjects(on: T.Properties.all, where: condition, orderBy: orderList, limit: limit, offset: offset)
            return objects
        } catch {
            return []
        }
    }

    public func getObject<T: TableCodable>(_ model: T.Type,
                                           tableName: String? = nil,
                                           where condition: Condition? = nil,
                                           orderBy orderList: [OrderBy]? = nil,
                                           offset: Offset? = nil) -> T?
    {
        let table = db.getTable(named: tableName ?? "\(model.self)", of: model.self)
        do {
            let object: T? = try table.getObject(on: T.Properties.all, where: condition, orderBy: orderList, offset: offset)
            return object
        } catch {
            return nil
        }
    }

//    ///查询
//    public func qurey<T: TableDecodable>(fromTable table: DBTableName, where condition: Condition? = nil, orderBy orderList:[OrderBy]? = nil) -> [T]? {
//        do {
//            let allObjects: [T] = try (db?.getObjects(fromTable: table.rawValue, where:condition, orderBy:orderList))!
//            debugPrint("\(allObjects)");
//            return allObjects
//        } catch let error {
//            debugPrint("no data find \(error.localizedDescription)")
//        }
//        return nil
//    }

//    /// 插入或更新
//    public func insertOrUpdateToDb<T: TableEncodable>(table: String, on propertys: [PropertyConvertible]? = nil, with object: [T], where condition: Condition? = nil) -> Void {
//        do {
//            try db?.insertOrReplace(objects: object, on: propertys, intoTable: table)
//        } catch let error {
//            debugPrint(error.localizedDescription)
//        }
//    }
//
//    ///删除数据表
//    func dropTable(table: DBTableName) -> Void {
//        do {
//            try db?.drop(table: table.rawValue)
//        } catch let error {
//            debugPrint("drop table error \(error)")
//        }
//    }
//
//    /// 删除所有与该数据库相关的文件
//    func removeDbFile() -> Void {
//        do {
//            try db?.close(onClosed: {
//                try db?.removeFiles()
//            })
//        } catch let error {
//            debugPrint("not close db \(error)")
//        }
//
//    }
}
