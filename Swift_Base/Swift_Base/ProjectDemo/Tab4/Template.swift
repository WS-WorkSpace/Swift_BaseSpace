//
//  Template.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/11.
//

import UIKit

class Template: UIView {
    
    /// XIB 读取的时候required init可以不写,写的话就会调用
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init(coder)")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
        /// 让控件不随着父控件的拉伸而拉伸
//        autoresizingMask = UIView.AutoresizingMask()
    }

    static func loadFromNib(_ nibname: String? = nil, index: Int = 0) -> Self { // Self(大写)当前类对象
        /// self(小写)当前对象
        // print("\(Self.self)")
        let loadName = nibname == nil ? "\(Self.self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)![index] as! Self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
         // Drawing code
     }
     */
}
