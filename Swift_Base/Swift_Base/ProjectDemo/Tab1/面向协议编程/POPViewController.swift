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
        let subString: URL? = "Jcak".ws.urlScheme(scheme: "www.baidu.com") // Optional(www.baidu.com:Jcak)
        print(subString)
        view.backgroundColor = UIColor.ws.rgbColor(r: 150, g: 100, b: 100)
        let colorString = view.backgroundColor?.ws.toHexString()
        print(colorString ?? "") // #966464
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
