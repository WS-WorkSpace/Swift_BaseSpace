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
