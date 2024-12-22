//
//  Version_Detail.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/20.
//

import Foundation

// MARK: UIScrollView适配iOS 11

extension UIScrollView {
    func neverAdjustContentInset() {
        if #available(iOS 11.0, *), self.responds(to: #selector(setter: self.contentInsetAdjustmentBehavior)) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
}
// MARK: tableView 在 iOS 11 上的适配

extension UITableView {
    func tableViewNeverAdjustContentInset() {
        if #available(iOS 11, *) {
            self.estimatedRowHeight = 0
            self.estimatedSectionFooterHeight = 0
            self.estimatedSectionHeaderHeight = 0
            self.contentInsetAdjustmentBehavior = .never
        }
    }
}

extension UINavigationController {
    func navuf() {
        // 设置导航栏背景颜色
        let navbarTintColor = UIColor.systemYellow
        // iOS 15后，需要手动设置UINavigationBar的scrollEdgeAppearance和standardAppearance属性才行
        if #available(iOS 13, *) {
            // 处于顶部时的背景
            let scrollEdgeAppearance = UINavigationBarAppearance()
            scrollEdgeAppearance.backgroundColor = navbarTintColor
            navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
            /*
             navigationBar.scrollEdgeAppearance = {
             let appearance = UINavigationBarAppearance()
             appearance.backgroundColor = .red
             return appearance
             }()
             */
            // 滑动后的背景
            let standardAppearance = UINavigationBarAppearance()
            standardAppearance.backgroundColor = navbarTintColor
            navigationBar.standardAppearance = standardAppearance
            /*
             navigationBar.standardAppearance = {
             let appearance = UINavigationBarAppearance()
             appearance.backgroundColor = .green
             return appearance
             }()
             */

            // 不设置任何属性则是默认的毛玻璃效果
        } else {
            navigationBar.barTintColor = navbarTintColor
        }
        let dict: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        // 标题颜色
        navigationBar.titleTextAttributes = dict
        // item颜色
        navigationBar.tintColor = UIColor.black
    }
}
