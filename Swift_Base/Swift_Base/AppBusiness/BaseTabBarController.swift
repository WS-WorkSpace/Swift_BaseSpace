//
//  BaseTabBarController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class BaseTabBarController: UITabBarController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
//        setValue(TabBar(), forKey: "tabBar")
        
        setupItemTitleTextAttributes();
        setupChildViewControllers()

        //        self.tabBar.tintColor = UIColor.yellowColor() //设置选中颜色，这里使用黄色
        // self.tabBar.tintColor =UIColor(red: 0/255, green:188/255, blue:212/255, alpha:1) //也可以自定义颜色
        // 升上iOS15后，发现使用系统提供的导航栏滑动时会变透明，navigationBar的barTintColor设置无效
        // https://www.jianshu.com/p/f7dc127ecda9?ivk_sa=1024320u
//        self.tabBar.barTintColor = UIColor.white;
    }
    /// 设置所有UITabBarItem的文字属性
    func setupItemTitleTextAttributes() {
        let normalColor = BaseTabBarNormalTextColor;
        let selectColor = BaseTabBarSelectTextColor;
        setTabBarColor(normalColor, selectColor, nil)
    }
    
    /// 添加所有子控制器
    func setupChildViewControllers() {
        self.addChildVC("主页", "home_1_normal", "home_1_selected", OneTabViewController.self)
        self.addChildVC("标签2", "home_ic_clip_p", "home_ic_clip_selected", TwoTabViewController.self)
        self.addChildVC("互相调用", "home_ic_notice_p", "home_ic_notice_selected", ThreeTabViewController.self)
        self.addChildVC("Temp", "home_ic_template_p", "home_ic_template_selected", FourTabViewController.self)
        self.addChildVC("个人", "tab5", "tab5_select", FiveTabViewController.self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func addChildVC(_ title: String, _ imageName: String, _ selectedImage: String, _ type: UIViewController.Type) {
        let childVC = type.init()
        let childNAVC = NavigationController(rootViewController: childVC)
//        childNAVC.title = title

        self.addChild(childNAVC)
        childVC.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImage))
//        childVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
//        // 声明：这张图片按照原始的样子显示出来，不要自动渲染成其他颜色（比如蓝色）
//        childVC.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)

        /// 设置图片偏移
//        childVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)


    }
    // MARK: - 设置TabBar 文字颜色和背景色

    func setTabBarColor(_ normalColor: UIColor, _ selectColor: UIColor, _ bgColor: UIColor?) {
        let tabBarItem = UITabBarItem.appearance()
        
        // 普通状态下的文字属性
        var normalAttrs = [NSAttributedString.Key: Any]()
        normalAttrs[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 10)
        normalAttrs[NSAttributedString.Key.foregroundColor] = normalColor
        // 选中状态下的文字属性
        var selectedAttrs = [NSAttributedString.Key: Any]()
        selectedAttrs[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 10)
        selectedAttrs[NSAttributedString.Key.foregroundColor] = selectColor
        
        tabBarItem.setTitleTextAttributes(normalAttrs, for: .normal)
        tabBarItem.setTitleTextAttributes(selectedAttrs, for: .selected)
        
        // iOS13适配，处理未选中颜色失效
        if #available(iOS 13.0, *) {
            UITabBar.appearance().unselectedItemTintColor = normalColor
        }
        // iOS15适配，处理tabBar背景和分割线透明，选中颜色失效
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            if bgColor != nil {
                appearance.backgroundColor = bgColor // tabBar背景颜色
            }
            //        appearance.backgroundEffect = nil; // 去掉半透明效果
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttrs
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttrs
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

}
