//
//  Swift_To_OCViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/16.
//

import UIKit

class Swift_Call_OC_ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.runOCMethod()
    }

    func runOCMethod() {
        let person = WS_Person(age: 10, name: "Rose")
        print(person.age, person.name)
        WS_Person.run()
        person.run()
        person.eat("huanggua", other: "mifan")
        print(sum(33, 44))
    }
}
