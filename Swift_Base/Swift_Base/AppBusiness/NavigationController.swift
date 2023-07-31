//
//  NavigationController.swift
//  WS_Networing_Swift
//
//  Created by 王爽 on 2023/7/15.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {

    var popDelegate: UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //https://www.jianshu.com/p/f7dc127ecda9?ivk_sa=1024320u
        self.view.backgroundColor = .white
        let primaryTextColor = UIColor.green
        // 解决侧滑返回失效问题
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationBar.layer.shadowRadius = 20
        self.navigationBar.layer.shadowOpacity = 0.2
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.navigationBar.tintColor = primaryTextColor
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .white

        let appearance = UINavigationBar.appearance()
        appearance.shadowImage = UIImage()
        appearance.layer.shadowColor = UIColor.blue.cgColor
        appearance.layer.shadowRadius = 20
        appearance.layer.shadowOpacity = 0.2
        appearance.layer.shadowOffset = CGSize(width: 0, height: 5)
        appearance.tintColor = primaryTextColor //前景色，按钮颜色
        appearance.isTranslucent = false // 导航条背景是否透明
        appearance.barTintColor = .white //背景色，导航条背景色
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: primaryTextColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)] // 设置导航条标题颜色，还可以设置其它文字属性，只需要在里面添加对应的属性
        
        // 解决iOS15 barTintColor设置无效的问题，参考https://developer.apple.com/forums/thread/682420
        if #available(iOS 15.0, *) {
            let newAppearance = UINavigationBarAppearance()
            newAppearance.configureWithOpaqueBackground()
            newAppearance.backgroundColor = .white
            newAppearance.shadowImage = UIImage()
            newAppearance.shadowColor = nil
            newAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: primaryTextColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
            
            appearance.standardAppearance = newAppearance
            appearance.scrollEdgeAppearance = appearance.standardAppearance
        }
    }
//https://blog.csdn.net/same_life/article/details/125320337
    private func setupAppearance() {
        //自定义navBar，根据当前的nav自定义 navBar
        let navBar = UINavigationBar.appearance()
        var attrTitleText = [NSAttributedString.Key: Any]()
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            //Opaque: 不透明
            navBarAppearance.configureWithOpaqueBackground()
            //设置导航栏的背景色
            navBarAppearance.backgroundColor = .secondarySystemGroupedBackground
            attrTitleText = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.tertiarySystemBackground]
            navBarAppearance.titleTextAttributes = attrTitleText as [NSAttributedString.Key: Any]
            navBar.standardAppearance = navBarAppearance
            navBar.scrollEdgeAppearance = navBarAppearance
        } else {
            attrTitleText = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
            //设置导航条的背景色
            navBar.barTintColor = .yellow
            navBar.titleTextAttributes = attrTitleText as [NSAttributedString.Key: Any]
        }
        //设置导航条不透明
        navBar.isTranslucent = false
        //设置除导航条以外的其他字体的颜色
        navBar.tintColor = .lightGray
    }
}
