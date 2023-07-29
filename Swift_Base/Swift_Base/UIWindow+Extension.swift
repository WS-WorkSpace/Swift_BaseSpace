//
//  UIWindow+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/29.
//

import Toast_Swift
import UIKit

extension UIWindow {
    static var keyWindow: UIWindow? {
        var originalKeyWindow: UIWindow?
        #if swift(>=5.1)
            if #available(iOS 13, *) {
                originalKeyWindow = UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .flatMap { $0.windows }
                    .first(where: { $0.isKeyWindow })
            } else {
                originalKeyWindow = UIApplication.shared.keyWindow
            }
        #else
            originalKeyWindow = UIApplication.shared.keyWindow
        #endif
        return originalKeyWindow
    }
}
