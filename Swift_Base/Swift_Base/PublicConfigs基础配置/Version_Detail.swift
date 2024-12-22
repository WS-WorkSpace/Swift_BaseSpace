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
