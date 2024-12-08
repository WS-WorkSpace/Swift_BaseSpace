//
//  ThreeTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import JKSwiftExtension
import UIKit
@objcMembers class Temp: NSObject {
    func test1(v1: Int) { print("test1") }
    func test2(v1: Int, v2: Int) { print("test2(v1:v2:)") }
    func test2(_ v1: Double, _ v2: Double) { print("test2(_:_:)") }
    func run() {
        perform(#selector(test1))
        perform(#selector(test1(v1:)))
        perform(#selector(test2(v1:v2:)))
        perform(#selector(test2(_:_:)))
        perform(#selector(test2 as (Double, Double) -> Void))
    }
}

class ThreeTabViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        view.addSubview(button)
        button.setTitle("测试", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.randomColor.cgColor
        button.backgroundColor = UIColor.randomColor
        button.addTarget(self, action: #selector(btnMethod), for: UIControl.Event.touchUpInside)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSizeMake(200, 100))
        }
        let dic: [String: Any] = ["key1": "value1", "key2": "value2"]
        print(dic.has("key1"))
        print(dic.jk.dictionaryToJson() as Any)

        test()
    }

    @objc func btnMethod() {
        print("点击了测试按钮")
    }

    typealias Fn = (Int) -> (Int)
    func sum(_ a: Int) -> Fn {
        { $0 + a }
    }

    func test() {}
}
