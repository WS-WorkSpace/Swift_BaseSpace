//
//  MoyaViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/28.
//

import UIKit
import Moya

enum WeatherService {
    case currentWeather(city: String)
    
    var urlPath: String {
        switch self {
        case .currentWeather(let city):
            return "/weather?city=\(city)"
        }
    }
}

class MoyaViewController: UIViewController {
    fileprivate var bookArray = [BookDetail]()
    lazy var mTableView: UITableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellID)
        return tabview
    }()
    lazy var mHeaderView:UIView = {
        let hView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 90))
        hView.backgroundColor = .magenta
        let leftBtn = UIButton.creatButton("简单使用",.white, CGRectZero, self, #selector(leftButton))
        leftBtn.layer.cornerRadius = 7
        hView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(kScreenWidth/2-10, 80))
            make.left.equalTo(5)
            make.top.equalTo(5)
        }
        let rightBtn = UIButton.creatButton("封装使用",.white, CGRectZero, self, #selector(rightButton))
        rightBtn.layer.cornerRadius = 7
        hView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(kScreenWidth/2-10, 80))
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
        }

        
        return hView
    }()
    @objc func leftButton(){
        mLog("点击左侧按钮")
//        let provider = MoyaProvider<T>(plugins: [
//            RequestHandlingPlugin(),
//            //            networkLoggerPlugin
//        ])

//        let provider = MoyaProvider<WeatherService>(endpointClosure: { target<WeatherService> -> Endpoint in
//            let url = URL(string: "https://api.example.com/weather")!
//            return Endpoint(url: url, method: HTTPMethod.get, parameters: target.parameters, encoding: JSONEncoding.default)
//        })

        
//        let provider = MoyaProvider<WeatherService>(endpointClosure: { target -> Endpoint<WeatherService> in
//            let url = URL(string: "https://api.example.com/weather")!
//            return Endpoint(url: url, method: HTTPMethod.get, parameters: target.parameters, encoding: JSONEncoding.default)
//        })
//        provider.request(.currentWeather(city: "New York")) { result in
//            switch result {
//            case .success(let response):
//                // 解析 response 并处理数据
//                print(response.mapJSON())
//            case .failure(let error):
//                print("Request failed with error: \(error)")
//            }
//        }
    }
    @objc func rightButton(){
        mLog("点击右侧侧按钮")
    }

    static let ItemCellID = "SwiftyJSONCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.tableHeaderView = mHeaderView
        view.addSubview(mTableView)
        getNetModel()
    }

    func getNetModel() {
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]
        mLog("aaaaa",API.getPageList(1))
        JhHttpTool.request(API.getPageList(1)) {[weak self] json in
//            self?.mTextView.text = String(describing: JSON(json))
//            mAllLog(JSON(json))
        } failure: {code, msg in
            mAllLog("code : \(code!)")
            mLog("message : \(msg)")
        }


    }

    deinit {
        print("SwiftyJSONViewController已经释放")
    }
}

extension MoyaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellID, for: indexPath)
        let descString = bookArray[indexPath.row].desc
        cell.textLabel?.text = descString
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension MoyaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descString = bookArray[indexPath.row].desc
        let contentHeight = descString.RD_getStringHeight(kScreenWidth - 10 - 10, 20)
        let cellHeight = contentHeight + 10 + 10
        return cellHeight
    }
}

