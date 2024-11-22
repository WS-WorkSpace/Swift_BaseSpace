//
//  MirrorViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/22.
//

import UIKit

struct Person {
    var age: Int = 0
    var name: String = ""
}

class MirrorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        execMirror()
    }

    func execMirror() {
        let mirror = Mirror(reflecting: Person(age: 18, name: "jack"))
        print(mirror.displayStyle!) // struct
        print(mirror.subjectType) // Person
        print(mirror.superclassMirror as Any) // nil  ,结构体没有父类
        for case let (label?, value) in mirror.children {
            // age 18
            // name jack
            print(label, value)
        }
    }
}
