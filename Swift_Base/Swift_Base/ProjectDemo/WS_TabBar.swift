//
//  TabBar.swift
//  WS_Networing_Swift
//
//  Created by 王爽 on 2023/7/15.
//

import UIKit

class WS_TabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupAppearance()
    }
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        //        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in self.subviews where subview is UIControl{
            var newFrame = subview.frame
            newFrame.origin.y -= 0 //上移20
            subview.frame = newFrame
        }
        
    }
    
    private func setupAppearance() {
        let tabBarColor = UIColor.white
        //ios 13不存在tabBar透明问题
        let tabBar = UITabBar.appearance()
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            //Opaque: 不透明
            tabBarAppearance.configureWithOpaqueBackground()
            //设置导航栏的背景色
            tabBarAppearance.backgroundColor = tabBarColor
            tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = tabBarAppearance
            }
        }
        //ios 13以下
        tabBar.isTranslucent = false
        tabBar.barTintColor = tabBarColor
    }
}
