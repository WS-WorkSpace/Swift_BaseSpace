//
//  ThreeTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import JKSwiftExtension
import UIKit

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
        var value = UserDefaults.userDefaultsGetValue(key: "key333")
        mlog(value as Any)
    }

    @objc func btnMethod() {
        print("点击了测试按钮")
        UserDefaults.userDefaultsSetValue(value: "dsasda", key: "key333")
    }

    typealias Fn = (Int) -> (Int)
    func sum(_ a: Int) -> Fn {
        { $0 + a }
    }

    func test() {}
}
