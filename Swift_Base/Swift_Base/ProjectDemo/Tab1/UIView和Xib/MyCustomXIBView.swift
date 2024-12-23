//
//  MyCustomXIBView.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/12.
//

import UIKit

class MyCustomXIBView: UIView {
    
    /**
     /// XIB 读取的时候required init可以不写,写的话就会调用
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         print("init(coder)")
     }
     */

    /**
     /// XIB 读取的时候awakeFromNib可以不写,写的话就会调用
     /// 让控件不随着父控件的拉伸而拉伸
     ///  autoresizingMask = UIView.AutoresizingMask()
     override func awakeFromNib() {
         super.awakeFromNib()
         print("awakeFromNib")
     }
      */

    static func loadFromNib(_ nibname: String? = nil, index: Int = 0) -> Self {
        let loadName = nibname == nil ? "\(Self.self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)![index] as! Self
    }

    /**
     override func layoutSubviews() {
         super.layoutSubviews()
     }
      */

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
         // Drawing code
     }的
     */
}
