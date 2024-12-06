//
//  APIProvider.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/14.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import Foundation
import HandyJSON
import Moya

// 首页接口
let APIProvider = MoyaProvider<API>()

enum API {
    case getPageList(_ page: Int)
    case homeGoodsList(parameters: [String: Any]) // 首页上面列表
    case homePageBelowConten(parameters: [String: Any]) // 首页下面列表
    case goodDetail(parameters: [String: Any]) // 商品详情
    case goodCategory(parameters: [String: Any]) // 商品类别信息
    case categoryGoodsList(parameters: [String: Any]) // 商品列表
}

// 遵循 TargetType 代理 实现方法
extension API: TargetType {
    // 服务器地址
    public var baseURL: URL {
//        return URL(string: "https://wxmini.baixingliangfan.cn/baixing/")!
        return URL(string: "http://rap2api.taobao.org/")!
    }

    var path: String {
        switch self {
        case .getPageList: return "app/mock/303994/test/dbbooklist"
        case .homeGoodsList: return "wxmini/homePageContent"
        case .homePageBelowConten: return "wxmini/homePageBelowConten"
        case .goodDetail: return "wxmini/getGoodDetailById"
        case .goodCategory: return "wxmini/getCategory"
        case .categoryGoodsList: return "wxmini/getMallGoods"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPageList:
            return .get
        default:
            return .post
        }
    }

    var task: Task {
        var parmeters: [String: Any] = [:]
        switch self {
        case .getPageList(let page):
            parmeters["page"] = page
            parmeters["limit"] = 15
            parmeters["maxCount"] = 100
        case .homeGoodsList(let parameters):
            parmeters = parameters
        case .homePageBelowConten(let parameters):
            parmeters = parameters
        case .goodDetail(let parameters):
            parmeters = parameters
        case .goodCategory(let parameters):
            parmeters = parameters
        case .categoryGoodsList(let parameters):
            parmeters = parameters
        }

        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    var headers: [String: String]? { return nil }

    // 是否显示转圈提示
    var show: Bool {
        return self.show
    }
}
