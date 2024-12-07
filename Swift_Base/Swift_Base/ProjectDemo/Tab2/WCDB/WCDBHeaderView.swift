//
//  WCDBHeaderView.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/6.
//

import UIKit
import WCDBSwift

//// 示例使用
// let observer = Observer()
// sendNotification()  // 这将打印 "Received notification with value: Hello, World!"

class WCDBHeaderViewControl {
    static let tableName = "ExampleItem"
    // 读取本地JSON文件,创建[ExampleItem],然后用于插表操作演示.
    static var models: [ExampleItem] = {
        let json = EasyTestModel.getLocalJSON("BookList", "json")
        let bookArr = json["list"].arrayValue
        var modelsArrTemp: [ExampleItem] = []
        for element in bookArr where bookArr.count > 0 {
            let num = element["num"].intValue
            let name = element["name"].stringValue
            let desc = element["desc"].stringValue
            let extmapModel = ExampleItem(authorNumber: num, authorName: name, desc: desc)
            modelsArrTemp.append(extmapModel)
        }
        return modelsArrTemp
    }()

    static func sendNotification() {
        NotificationCenter.default.post(name: .WCDBHeaderViewNotification, object: nil, userInfo: ["key": "刷新数据库"])
    }
}

class WCDBHeaderView: UIView, NibLoadable {
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var changeBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        /// 让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()

        if #available(iOS 14.0, *) {
            setupSubViews()
        } else {
            // Fallback on earlier versions
        }
    }

    @available(iOS 14.0, *)
    private func setupSubViews() {
        addBtn.showsMenuAsPrimaryAction = true
        addBtn.menu = addMenuItems()

        deleteBtn.showsMenuAsPrimaryAction = true
        deleteBtn.menu = deleteMenuItems()
        changeBtn.showsMenuAsPrimaryAction = true
        changeBtn.menu = changeMenuItems()
        //            checkBtn.showsMenuAsPrimaryAction = true
        //            checkBtn.menu = checkMenuItems()
        //            tableBtn.showsMenuAsPrimaryAction = true
        //            tableBtn.menu = tableMenuItems()
        //            transactionBtn.showsMenuAsPrimaryAction = true
        //            transactionBtn.menu = transactionMenuItems()
        //            integratedQueryBtn.showsMenuAsPrimaryAction = true
        //            integratedQueryBtn.menu = integratedQueryMenuItems()
    }
}

// MARK: - 增

private func addMenuItems() -> UIMenu {
    let addAction1 = UIAction(title: "insert") { _ in
        let object = ExampleItem()
        object.authorNumber = Int.random(in: 0 ... 3)
        let arr = ["Jim", "Rose", "Tom", "jack", "Li"]
        object.authorName = arr.randomElement()
        let description = ["一个数学家", "小学生", "程序员", "艺人", "吃瓜群众"]
        object.desc = description.randomElement()
        // 纯插入操作，由于设置了identifier为主键，所以identifier必须唯一，不然插入必失败并打印错误
        MYDB.insert(objects: object, intoTable: WCDBHeaderViewControl.tableName)
        WCDBHeaderViewControl.sendNotification()
    }
    let addAction2 = UIAction(title: "insertOrReplace") { _ in
        // 当主键重复时即为更新，不重复时即直接插入数据
        DBManager.shared.insertOrReplace(WCDBHeaderViewControl.models, tableName: WCDBHeaderViewControl.tableName)
        WCDBHeaderViewControl.sendNotification()
    }
    return UIMenu(children: [addAction1, addAction2])
}

// MARK: - 删

private func deleteMenuItems() -> UIMenu {
    let deleteAction = UIAction(title: "delete") { _ in
        // delete(fromTable table: String,where condition: Condition? = nil,orderBy orderList: [OrderBy]? = nil,limit: Limit? = nil,offset: Offset? = nil)，这五个组合起来可以理解为：将 table 表内，满足 condition 的数据，按照 orderList 的方式进行排序，然后从头开始第 offset 行数据后的 limit 行数据删除，各参数代表的含义：table：表名,condition：条件，这儿可以多个条件合并，orderList：排序规则，这儿是数组，可以有多个列的排序规则，limit：无offset时理解为前 limit 行，有offset时理解为后 limit 行，offset：前 offset 行
        let condition: Condition = ExampleItem.Properties.authorNumber <= 5
        // && ExampleItem.Properties.authorName == "abc"

        try? DBManager.shared.db.delete(fromTable: "ExampleItem",
                                        where: condition,
                                        orderBy: [ExampleItem.Properties.authorNumber.asOrder().order(.descending)],
                                        limit: 100)
        WCDBHeaderViewControl.sendNotification()
    }

    return UIMenu(children: [deleteAction])
}

// MARK: - 改

private func changeMenuItems() -> UIMenu {
    // propertyConvertibleList、condition、limit 和 offset 前面介绍过了，两个更新不同的在with参数，on后的参数代表需要更新的列
    let changeAction1 = UIAction(title: "基于对象的更新(update with object)") { _ in
        let object = ExampleItem()
        object.authorNumber = Int.random(in: 0 ... 10)
        object.authorName = "张三"
        object.desc = "更新一条数据"
        try? DBManager.shared.db.update(table: "ExampleItem",
                                        on: ExampleItem.Properties.all,
                                        with: object,
                                        where: ExampleItem.Properties.authorNumber == 1)
        WCDBHeaderViewControl.sendNotification()
    }
    let changeAction2 = UIAction(title: "基于值的更新(update with row)") { _ in
        let row: [ColumnCodable] = ["update with row"]
        // 当on后的参数包含authorName而未设定authorName的值时，会置空
        try? DBManager.shared.db.update(table: "ExampleItem",
                                        on: [ExampleItem.Properties.desc, ExampleItem.Properties.authorName],
                                        with: row,
                                        where: ExampleItem.Properties.desc == "更新一条数据" && ExampleItem.Properties.authorName > 0)
        WCDBHeaderViewControl.sendNotification()
    }

    return UIMenu(children: [changeAction1, changeAction2])
}

// MARK: - 查

// WCDBViewController文件readLocalDataBase方法下,查询并刷新数据库
