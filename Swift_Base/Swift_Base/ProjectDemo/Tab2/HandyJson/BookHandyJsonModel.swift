//
//  BookHandyJsonModel.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/24.
//

import HandyJSON
import UIKit

class BookHandyJsonModel: NSObject, HandyJSON {
//    @objc var list:String?
    @objc var list = [BookModel()] // 嵌套模型

    override required init() {}

    override var description: String {
        return self.dictionaryWithValues(forKeys: ["list"]).description
    }
}

class BookModel: NSObject, HandyJSON {
    @objc var desc: String?
    @objc var name: String?
    @objc var num: String?
//    @objc var temp:String = ""
//    @objc var temp2:String = ""
//    @objc var info = Info()//嵌套模型
    override required init() {}
    var cellHeight: CGFloat {
        var height = 0.0
        let labelWidrh = kScreenWidth - 130
        let font = 17.0
        guard let contentHeight = desc?.RD_getStringHeight(labelWidrh, font) else { return 0 }
        height += contentHeight
        height += 10 + 10
        return height > 60 ? height : 60.0
    }

    override var description: String {
        return self.dictionaryWithValues(forKeys: ["desc",
                                                   "name",
                                                   "num"]).description

//        return self.dictionaryWithValues(forKeys: ["desc",
//                                                "name",
//                                                "num",
//                                                "info",
//                                                "temp",
//                                                "temp2"]).description
    }
//    mutating func mapping(map: ObjectMapper.Map) {
//        desc            <- map["desc"]
//        name            <- map["name"]
//        num             <- map["num"]
//    }
//    init?(map: ObjectMapper.Map) {
//
//    }
}

// 子模型
class BookInfo: NSObject, HandyJSON {
    @objc var img: String = ""
    @objc var name: String = ""
    override required init() {}

    override var description: String {
        return self.dictionaryWithValues(forKeys: ["img",
                                                   "name"]).description
    }
}
