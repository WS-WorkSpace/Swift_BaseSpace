//
//  SettingViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class SettingViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        navLeftTitle = "返回"
        ClickNavLeftItemBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        /// 设置右侧一个按钮
        // navRightImage = ("tab5", "tab5_select")
        /// 设置右侧多个按钮
        let item1 = UIBarButtonItem.RD_imageItem(imageName: navRightImage ?? ("tab5", "tab5_select"), target: self, action: #selector(ClickRightItem))
        let item2 = UIBarButtonItem.RD_imageItem(imageName: navRightImage ?? ("tab3", "tab3_select"), target: self, action: #selector(ClickRightItem))
        navigationItem.rightBarButtonItems = [item1, item2]

        ClickNavRightItemBlock = {
            Lg.log("点击右侧item")
        }

        /// BaseVC添加屏幕点击手势,取消键盘,回调
        hideKeyboardWhenTapedAround()
        ClickKeyboard = {
            Lg.log("屏幕点击手势")
        }
    }
}
