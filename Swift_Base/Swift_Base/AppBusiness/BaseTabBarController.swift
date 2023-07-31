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

        self.addChildVC("主页", "home_1_normal", "home_1_selected", OneTabViewController.self)
        self.addChildVC("标签2", "home_ic_clip_p", "home_ic_clip_selected", TwoTabViewController.self)
        self.addChildVC("互相调用", "home_ic_notice_p", "home_ic_notice_selected", ThreeTabViewController.self)
        self.addChildVC("Temp", "home_ic_template_p", "home_ic_template_selected", FourTabViewController.self)
        self.addChildVC("个人", "tab5", "tab5_select", FiveTabViewController.self)

        //        self.tabBar.tintColor = UIColor.yellowColor() //设置选中颜色，这里使用黄色
        // self.tabBar.tintColor =UIColor(red: 0/255, green:188/255, blue:212/255, alpha:1) //也可以自定义颜色
        // 升上iOS15后，发现使用系统提供的导航栏滑动时会变透明，navigationBar的barTintColor设置无效
        // https://www.jianshu.com/p/f7dc127ecda9?ivk_sa=1024320u
//        self.tabBar.barTintColor = UIColor.white;
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func addChildVC(_ title: String, _ imageName: String, _ selectedImage: String, _ type: UIViewController.Type) {
        let childVC = NavigationController(rootViewController: type.init())
//        let childVC = type.init()
        self.addChild(childVC)
        childVC.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImage))
        /// 设置图片偏移
//        childVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

        let attributedArray = [NSAttributedString.Key.foregroundColor: UIColor.black,
                               NSAttributedString.Key.backgroundColor: UIColor.green,
                               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50)]
        childVC.tabBarItem.setTitleTextAttributes(attributedArray, for: .selected)

        //        let naVC2 = UINavigationController(rootViewController: type.init())
        //        naVC2.tabBarItem.title = title
        //        naVC2.tabBarItem.image = UIImage(named: imageName)
        //        naVC2.tabBarItem.selectedImage = UIImage(named: selectedImage)
        //        self.addChild(naVC2)
    }
}
