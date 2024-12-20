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
        
        let label = UILabel()
        label.backgroundColor = .gray
        let labelText = "这时一个测试的label."
        label.text = labelText
//        label.sizeToFit()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(button.snp.bottom).offset(30)
        }
        
        let mutableAttributedString = NSMutableAttributedString(string: labelText)
        let mufont = UIFont.systemFont(ofSize: 22)
        let range = NSRange(location: 1, length: 3)
        let attributes = [NSAttributedString.Key.font : mufont]
        //UIFont.systemFont(ofSize: 30)
        for name in attributes.keys {
            mutableAttributedString.addAttribute(name, value: attributes[name] ?? "", range: range)
        }
        label.attributedText = mutableAttributedString
        
        let easyBtn = UIButton.easyButton("简单Btn"){btn in
            btn?.backgroundColor = UIColor.randomColor
            mlog("点击了按钮")
        }
        easyBtn.backgroundColor = .cyan
        view.addSubview(easyBtn)
        easyBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(200, 100))
            make.top.equalTo(label.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
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
