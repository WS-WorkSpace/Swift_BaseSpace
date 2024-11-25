//
//  BookHandyJsonModel.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/24.
//

import HandyJSON
import UIKit

class BookHandyJsonModel: HandyJSON {
    var list = [BookModel()] // 嵌套模型
    required init() {}
}

class BookModel: HandyJSON {
    var desc: String?
    var name: String?
    var num: String?
    var my_desc: String = ""
    var my_name: String = ""
//    @objc var info = Info()//嵌套模型
    required init() {}
    var cellHeight: CGFloat {
        var height = 0.0
        let labelWidrh = kScreenWidth - 130
        let font = 17.0
        guard let contentHeight = desc?.RD_getStringHeight(labelWidrh, font) else { return 0 }
        height += contentHeight
        height += 10 + 10
        return height > 60 ? height : 60.0
    }

    func mapping(mapper: HelpingMapper) {
        mapper <<< self.my_desc <-- "desc" // 把desc 转换为模型中的 my_desc
        mapper <<< self.my_name <-- "name" // 把name 转换为模型中的 my_name
    }
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
