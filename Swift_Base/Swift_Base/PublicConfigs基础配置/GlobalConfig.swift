//
//  GlobalConfig.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import Foundation
import UIKit

public let USER_IMG_URl = "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666#/"

public enum GlobalConfig {
    // MARK: - Config Info

    public static let gBaseUrl = "192.168.1.177"
    // public static let gBaseUrl = "192.168.1.105"

    public static let gRpcUrl = gBaseUrl
    public static let gRestUrl = "http://\(gBaseUrl):9098/grpc"
    public static let gCharHost = "http://\(gBaseUrl):9100"

    // /Users/wangshuang/Desktop/WS_Bench/Swift_BaseSpace/Swift_Base/Swift_Base/ProjectDemo/Tab2/HandyJson/BookHandyJsonModel.swift高德地图key
    public static let gGaoDeMapKey = "b00c88f69a38f58eee2a00b6ebe1abda"

    /// GET 请求
    /// "http://cx.shouji.360.cn/phonearea.php?number=13012345678"
    /// 图书列表链接
    public static let BOOKLIST_URL = "http://rap2api.taobao.org/app/mock/303994/test/dbbooklist"
    public static let USERDETAIL_URL = "https://raw.githubusercontent.com/xiaoyouxinqing/PostDemo/master/PostDemo/Resources/PostListData_recommend_1.json"
    /// http://cx.shouji.360.cn/phonearea.php?number=13012345678  //需要支持@"text/html"
    // GET 请求
//        let strURL = "https://mobi.hsxt.cn:9446/refactor/lcs/queryProvinceTree"
//        let strURL1 = "http://rap2api.taobao.org/app/mock/303994/test/dbbooklist"
//        let strURL2 = "/phonearea.php?"
//        let strURL3 = "https://raw.githubusercontent.com/xiaoyouxinqing/PostDemo/master/PostDemo/Resources/PostListData_recommend_1.json"

    // 下载,上传 的接口查看tab4_基于AFN封装的网络请求模块
    


    // MARK: -  UI
}
