//
//  Swift_To_OCViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/16.
//

import UIKit

/*
 如果知道系统级别的函数，但是该函数没有头文件暴露，可以用这个方法调用。
 比如用下面的方法：
 第一步我们在上面WS_Person.h中去掉int sum(int a, int b);函数声明
 第二步，然后在Swift文件中全局区
 @_silgen_name("sum")
 func sum(_ v1: Int32, _ v2: Int32) -> Int32
 第三步，直接调用sum(33, 44)
 */
@_silgen_name("sum")
func sum(_ v1: Int32, _ v2: Int32) -> Int32

class Swift_Call_OC_ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        runOCMethod()
    }

    func runOCMethod() {
        let person = WS_Person(age: 10, name: "Rose")
        print(person.age, person.name)
        WS_Person.run()
        person.run()
        person.eat("糖醋排骨", other: "米饭")
        print(sum(33, 44))
    }
}
