//
//  HandyJsonModel.swift
//  WS_Networing_Swift
//
//  Created by 王爽 on 2023/7/19.
//

import Foundation
import HandyJSON

//https://blog.csdn.net/boildoctor/article/details/122364033
class TotalModel:NSObject,HandyJSON{
//    @objc var list:String?
    @objc var list = [HandyJsonModel()]//嵌套模型

    required override init(){
    }
    override var description:String  {
        return self.dictionaryWithValues(forKeys: ["list",
//                                                "handyJsonModel"
                                                ]).description
    }
}


class HandyJsonModel: NSObject, HandyJSON {
    @objc var desc:String?
    @objc var name:String?
    @objc var num:String?
//    @objc var temp:String = ""
//    @objc var temp2:String = ""
//    @objc var info = Info()//嵌套模型
    required override init(){
        
    }
     var cellHeight:CGFloat {
        get {
            var height = 0.0
            let labelWidrh = 120.0
            let font = 17.0
            guard let contentHeight = desc?.RD_getStringHeight(labelWidrh, font) else { return 0 }
            height += contentHeight
            height += 10 + 10
//            JhLog("height : \(height)")
            return height>60 ? height : 60.0
        }
    }

//    func mapping(mapper: HelpingMapper) {
//        mapper <<< self.temp <-- "access_token"  //把access_token 转换为模型中的 temp
//        mapper <<< self.temp2 <-- "refresh_token"  //把access_token 转换为模型中的 temp
//    }
    override var description:String  {
        return self.dictionaryWithValues(forKeys: ["desc",
                                                "name",
                                                "num"
                                                ]).description

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
//子模型
class Info:NSObject,HandyJSON{
    @objc var img:String = ""
    @objc var name:String = ""
    required override init(){
    }
    override var description:String  {
        return self.dictionaryWithValues(forKeys: ["img",
                                                   "name"
                                                  ]).description
    }
}
