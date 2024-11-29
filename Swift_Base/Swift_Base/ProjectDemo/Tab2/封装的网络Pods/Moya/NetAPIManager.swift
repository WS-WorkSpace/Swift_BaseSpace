//
//  NetAPIManager.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/13.
//

import Foundation
import Moya

/// 基础域名
let kBaseURL = "http://rap2api.taobao.org/"

enum API {
    case login(params: [String: Any])
    // 获取分页数据
    case getPageList(_ page: Int)
    // 获取分页数据 - post
    case getPageListPost(_ page: Int)
    // 获取分组分页数据
    case getGroupPageList(page: Int)
    // 获取联系人数据
    case getWxContact
    // 获取微信运行排行榜
    case getWxMotionTops
    // 获取固定数据
    case getSimpleDict
    case getSimpleArrDict
    /// 其他接口...
    case other1(p1: String, p2: Int, p3: String, p4: String)
    case other2
}

// MARK: - 补全【MoyaConfig 3：配置TargetType协议可以一次性处理的参数】中没有处理的参数

extension API: TargetType {
    // 0. 服务器地址,基础域名
    var baseURL: URL {
        switch self {
        case .login:
            return URL(string: kBaseURL)!
        default:
            return URL(string: kBaseURL)!
        }
    }

    // 1. 每个接口的相对路径,请求时的绝对路径是   baseURL + path
    var path: String {
        switch self {
        case .login:
            return "/mock/login"
        case .getPageList:
            return "app/mock/303994/test/dbbooklist"
        case .getPageListPost:
            return "/mock/pages"
        case .getGroupPageList:
            return "/mock/groupPages"
        case .getWxContact:
            return "/mock/wx/contacts"
        case .getWxMotionTops:
            return "/mock/wx/motionTops"
        case .getSimpleDict:
            return "/mock/simpleDict"
        case .getSimpleArrDict:
            return "/mock/simpleArrDict"
        case let .other1(p1, p2, _, _):
            return "/list?id=\(p1)&page=\(p2)"
        case .other2:
            return ""
        }
    }

    // 2. 每个接口要使用的请求方式
    var method: Moya.Method {
        switch self {
        case
            .getPageList,
            .getGroupPageList,
            .getWxContact,
            .getWxMotionTops,
            .getSimpleDict,
            .getSimpleArrDict,
            .other1,
            .other2:
            return .get
        case
            .getPageListPost,
            .login:
            return .post
        }
    }

    // 3.请求任务事件（这里附带上参数）. Task是一个枚举值，根据后台需要的数据，选择不同的http task。
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .login:
            return .requestPlain
        case let .getPageList(page):
            params["page"] = page
            params["limit"] = 15
            params["maxCount"] = 100
        case
            //            let   .getPageList(page),
            let .getPageListPost(page):
            params["page"] = page
            params["limit"] = 15
            params["maxCount"] = 100
        case let .other1(_, _, p3, p4):
            params["p3"] = p3
            params["p4"] = p4
        default:
            // 不需要传参数的接口走这里
            return .requestPlain
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }

//    //是否执行Alamofire验证
//    public var validate: Bool {
//        return false
//    }
}
