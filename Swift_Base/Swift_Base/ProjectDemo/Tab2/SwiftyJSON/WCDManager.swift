//
//  WCDManager.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/4.
//

import UIKit
import WCDBSwift

class DBManager: NSObject {
    
    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/myWCDB.db")
    
    private override init() {
        db = Database(at: path)
        print("WCDB数据库地址",path)

        //全局性能监控
        Database.globalTrace { tag, path, handleId, sql, cost in
            print("WCDB数据库性能指标： tag \(tag) id \(handleId) at path \(path) takes \(cost) seconds to execute sql \(sql)");
        }
        
        //全局错误监控
        Database.globalTrace(ofError: { (error: WCDBError) in
            #if DEBUG
            assert(error.level != .Fatal)
            #endif
            
            if error.level == .Ignore {
                print("可忽略WCDB数据库信息",error)
            } else {
                print("WCDB数据库错误",error)
            }
        })
        
        db.setNotification { corruptedDatabase in
            print("Database is corrupted: tag \(corruptedDatabase.tag ?? 0), path \(corruptedDatabase.path)")
            //WCDB 检测到损坏之后，isAlreadyCorrupted会始终返回 YES
            print("WCDB数据库有损坏",corruptedDatabase.isAlreadyCorrupted())// 输出1
        }
    }
    
    static let shared:DBManager = DBManager.init()
    
    public var db:Database!
    
    //MARK: - 创建表
    public func createTable<T:TableCodable>(name:String? = nil, model:T.Type) {
        try? db.create(table: name ?? "\(T.self)", of: T.self)
    }
  
    //MARK: - 增
    public func insertOrReplace<T:TableCodable>(_ objects:T..., tableName:String? = nil, on propertyConvertibleList: [PropertyConvertible]? = nil) {
        let table = db.getTable(named: tableName ?? "\(T.self)", of: T.self)
        try? table.insertOrReplace(objects, on: propertyConvertibleList)
    }
    
    public func insertOrIgnore<T:TableCodable>(_ objects:T..., tableName:String? = nil, on propertyConvertibleList: [PropertyConvertible]? = nil) {
        let table = db.getTable(named: tableName ?? "\(T.self)", of: T.self)
        try? table.insertOrIgnore(objects, on: propertyConvertibleList)
    }
    
    //MARK: - 删
    public func delete<T:TableCodable>(_ model:T.Type,
                                       tableName:String? = nil,
                                       where condition: Condition? = nil,
                                       orderBy orderList: [OrderBy]? = nil,
                                       limit: Limit? = nil,
                                       offset: Offset? = nil) {
        let table = db.getTable(named: tableName ?? "\(model.self)",of: model.self)
        try? table.delete(where: condition, orderBy: orderList, limit: limit, offset: offset)
    }
    
    //MARK: - 改
    public func update<T:TableCodable>(tableName:String? = nil,
                                       on propertyConvertibleList: PropertyConvertible...,
                                       with object: T,
                                       where condition: Condition? = nil,
                                       orderBy orderList: [OrderBy]? = nil,
                                       limit: Limit? = nil,
                                       offset: Offset? = nil) {
        let table = db.getTable(named: tableName ?? "\(T.self)",of: T.self)
        try? table.update(on: propertyConvertibleList, with: object, where: condition, orderBy: orderList, limit: limit, offset: offset)
    }
    
    //MARK: - 查
    public func getObjects<T:TableCodable>(_ model:T.Type,
                                           tableName:String? = nil,
                                           where condition: Condition? = nil,
                                           orderBy orderList: [OrderBy]? = nil,
                                           limit: Limit? = nil,
                                           offset: Offset? = nil) -> [T] {
        let table = db.getTable(named: tableName ?? "\(model.self)",of: model.self)
        do {
            let objects:[T] = try table.getObjects(on: T.Properties.all, where: condition, orderBy: orderList, limit: limit, offset: offset)
            return objects
        } catch {
            return []
        }
    }
    
    public func getObject<T:TableCodable>(_ model:T.Type,
                                           tableName:String? = nil,
                                           where condition: Condition? = nil,
                                           orderBy orderList: [OrderBy]? = nil,
                                           offset: Offset? = nil) -> T? {
        let table = db.getTable(named: tableName ?? "\(model.self)",of: model.self)
        do {
            let object:T? = try table.getObject(on: T.Properties.all, where: condition, orderBy: orderList, offset: offset)
            return object
        } catch {
            return nil
        }
    }
    
    
}
