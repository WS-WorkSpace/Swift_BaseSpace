//
//  MBProgressHUD+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import Foundation
import MBProgressHUD

// Alert.show(type: .error, text: message)
class MBProgressHUD_Alert: NSObject {
    enum AlertType {
        case success
        case info
        case error
        case warning
    }

    class func show(type: AlertType, text: String) {
        if let window = UIApplication.shared.delegate?.window {
            var image: UIImage
            switch type {
            case .success:
                let extractedExpr = #imageLiteral(resourceName: "Alert_success")
                image = extractedExpr
            case .info:
                image = #imageLiteral(resourceName: "Alert_info")
            case .error:
                image = #imageLiteral(resourceName: "Alert_error")
            case .warning:
                image = #imageLiteral(resourceName: "Alert_warning")
                // #imageLiteral(resourceName: "Alert_info")
            }
            let hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            hud.mode = .customView
            hud.customView = UIImageView(image: image)
            hud.label.text = text
            hud.hide(animated: true, afterDelay: 1.2)
        }
    }
}

// ProgressHUD.show()
class ProgressHUD {
    class func show() {
        if let window = UIApplication.shared.delegate?.window {
            MBProgressHUD.showAdded(to: window!, animated: true)
        }
    }

    class func hide() {
        if let window = UIApplication.shared.delegate?.window {
            MBProgressHUD.hide(for: window!, animated: true)
//            MBProgressHUD.hideAllHUDs(for: window!, animated: true)
        }
    }
}
