//
//  NibLoadable.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/12.
//

import Foundation


extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}

/// 定义一个协议
protocol NibLoadable {
    /// 具体实现写到 extension 中
}

/// 加载xib
extension NibLoadable where Self: UIView {
    /* Xib 和 类名 同名
     * lazy var headerView = HomeHeaderView.loadFromNib()
     * Xib 和 类名 不同名
     *  lazy var sectionView = HomeHeaderView.loadFromNib("sectionView")
     * Xib 中多个 View 视图
     * lazy var sectionView = Level1SectionView.loadFromNib("Level1HeaderView",index: 1)
     * https://www.jianshu.com/p/cceeaaff0397
     */

    /// 协议中不能定义class
    static func loadFromNib(_ nibname: String? = nil, index: Int = 0) -> Self { // Self(大写)当前类对象
        /// self(小写)当前对象
        // print("\(Self.self)")
        let loadName = nibname == nil ? "\(Self.self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)![index] as! Self
    }
}
