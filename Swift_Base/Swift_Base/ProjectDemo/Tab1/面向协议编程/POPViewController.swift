//
//  POPViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/20.
//

import UIKit

class POPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Jack".ws.addPrefix("Hello:")) // Hello:Jack

        let str: NSString = "test."
        print(str.ws.strTest())

        let subString: URL? = "Jcak".ws.urlScheme(scheme: "www.baidu.com") // Optional(www.baidu.com:Jcak)
        print(subString as Any)
        view.backgroundColor = UIColor.ws.rgbColor(r: 150, g: 100, b: 100)

        let colorString = view.backgroundColor?.ws.toHexString()
        print(colorString ?? "") // #966464

        // 利用协议实现类型判断
        func isArray(_ value: Any) -> Bool { value is [Any] }
        // 如果是判断数组类型，传入一个类判断类型是否是数组
        [Int].self is [Int].Type // true
        testType() // true false true true true
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
