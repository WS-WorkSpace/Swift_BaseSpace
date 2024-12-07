//
//  WCDBHeaderView.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/6.
//

import UIKit

//// 示例使用
//let observer = Observer()
//sendNotification()  // 这将打印 "Received notification with value: Hello, World!"

func sendNotification() {
    NotificationCenter.default.post(name: .WCDBHeaderViewNotification, object: nil, userInfo: ["key": "刷新数据库"])
}


class WCDBHeaderView: UIView, NibLoadable {
    @IBOutlet var addBtn: UIButton!

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
        //            deleteBtn.showsMenuAsPrimaryAction = true
        //            deleteBtn.menu = deleteMenuItems()
        //            changeBtn.showsMenuAsPrimaryAction = true
        //            changeBtn.menu = changeMenuItems()
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

private func addMenuItems() -> UIMenu {
    let addAction1 = UIAction(title: "insert") { _ in
        let tableName = "ExampleItem"
        MYDB.createTable(name: "ExampleItem", model: ExampleItem.self)
        let object = ExampleItem()
        object.authorNumber = Int.random(in: 0 ... 3)
        let arr = ["Jim", "Rose", "Tom", "jack", "Li"]
        object.authorName = arr.randomElement()
        let description = ["一个数学家", "小学生", "程序员", "艺人", "吃瓜群众"]
        object.desc = description.randomElement()
        // 纯插入操作，由于设置了identifier为主键，所以identifier必须唯一，不然插入必失败并打印错误
        MYDB.insert(objects: object, intoTable: tableName)
        print(object.lastInsertedRowID)
        sendNotification()
    }
//    let addAction2 = UIAction.init(title: "insertOrReplace") { _ in
//        let object = Sample()
//        object.identifier = 1
//        object.description = "abcd"
//        //当主键重复时即为更新，不重复时即直接插入数据
//
//        try? DBManager.shared.db.insertOrReplace(object, intoTable: "\(Sample.self)")
//    }
//    let addAction3 = UIAction.init(title: "insertOrIgnore") { _ in
//        let object = Sample()
//        object.identifier = 1
//        object.description = "abcdefg"
//        //当出现主键重复时，直接忽略此操作，不重复时才插入
//
//        try? DBManager.shared.db.insertOrIgnore(object, intoTable: "\(Sample.self)")
//    }
    ////    let addAction4 = UIAction.init(title: "带自定义对象insert") { _ in
    ////        let object = Sample()
    ////        //由于设置了主键identifier为自增，这儿identifier会视数据库中的最大值自增
    ////        object.description = "自定义对象存储"
    ////        guard let data = try? JSONEncoder().encode(["variable1": "1","variable2": "2"]) else {return}
    ////        let cuModel = Customer(with: Value(data))
    ////        object.myClass = cuModel
    ////        //这儿的Customer自定义对象我们使用二进制存储，存储自定义对象只需要遵循ColumnCodable协议，且实现init?(with Value)和archivedValue方法，这两个方法相当于是解归档
    ////
    ////        try? DBManager.shared.db.insert(object, intoTable: "\(Sample.self)")
    ////    }
    ////    let addAction5 = UIAction.init(title: "Sample设置了description不为空而传入空值") { _ in
    ////        let object = Sample()
    ////        object.identifier = 10
    ////        //Sample设置了description不可为空，这样插入会失败且报错
    ////
    ////        try? DBManager.shared.db.insert(object, intoTable: "\(Sample.self)")
    ////    }
//    return UIMenu.init(children: [addAction1,addAction2,addAction3,addAction4,addAction5])
    return UIMenu(children: [addAction1])
}
