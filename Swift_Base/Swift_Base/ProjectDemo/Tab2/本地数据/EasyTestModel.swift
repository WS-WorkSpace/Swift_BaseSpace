//
//  EasyNetWorking.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/23.
//

import Foundation
import SwiftyJSON

struct EasyTestModel {
    static func readJsonWithFileName(_ forResourceName: String, _ type: String) -> [String: Any] {
        let path = Bundle.main.path(forResource: forResourceName, ofType: type) ?? ""
        var dict = [String: Any]()
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return dict
    }

    /// 本地获取JSON
    static func getLocalJSON(_ forResourceName: String, _ type: String) -> JSON {
        let path = Bundle.main.path(forResource: forResourceName, ofType: type) ?? ""
        var json = JSON()
        do {
            let data: Data = try Data(contentsOf: URL(fileURLWithPath: path))
            json = try JSON(data: data)
            return json
        } catch {
            print("读取本地文件失败:\(error.localizedDescription)")
        }
        return json
    }

//    static func get(_ url: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
//        // Alamofire GET 请求
//
//    }
    static func syncRequest() {
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]

//        let semaphore = DispatchSemaphore(value: 0)

        DispatchQueue.global().async {
            Alamofire.request(url, method: .get, parameters: parameters)
                .responseJSON { response in
                    // 处理响应结果
                    if let json = response.result.value {
                        print("Response JSON: \(json)")
                    }
//                    semaphore.signal()
                }
        }
//        semaphore.wait()
    }
//    static func post(_ url: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
//        // Alamofire POST 请求
//    }
}

// 普通请求
// public func request(
//    _ url: URLConvertible,
//    method: HTTPMethod = .get,
//    parameters: Parameters? = nil,
//    encoding: ParameterEncoding = URLEncoding.default,
//    headers: HTTPHeaders? = nil)
//    -> DataRequest
// {
//    return SessionManager.default.request(
//        url,
//        method: method,
//        parameters: parameters,
//        encoding: encoding,
//        headers: headers
//    )
// }
