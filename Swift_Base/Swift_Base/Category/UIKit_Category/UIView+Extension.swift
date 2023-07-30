//
//  UIView+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit

public extension UIView {
    /// 视图添加圆角（可添加部分圆角）
    func RD_addCorner(conrners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

public extension UIView {
    var RD_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var RD_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var RD_width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newValue) {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var RD_height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newValue) {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var RD_centerX: CGFloat {
        get {
            return self.center.x
        }
        set(newValue) {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var RD_centerY: CGFloat {
        get {
            return self.center.y
        }
        set(newValue) {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    var RD_maxX: CGFloat {
        return self.frame.maxX
    }
    
    var RD_maxY: CGFloat {
        return self.frame.maxY
    }
    
    var RD_midX: CGFloat {
        return self.frame.midX
    }
    
    var RD_midY: CGFloat {
        return self.frame.midY
    }
    
    var RD_size: CGSize {
        get {
            return self.frame.size
        }
        set(newValue) {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    var RD_origin: CGPoint {
        get {
            return self.frame.origin
        }
        set(newValue) {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var RD_left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var RD_top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var RD_right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    var RD_bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    /// 渐变色
    func RD_gradientColor(_ startColor: UIColor, _ endColor: UIColor, _ startPoint: CGPoint, _ endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.addSublayer(gradientLayer)
    }
    
    /// 删除所有的子视图
    func RD_removeAllSubviews() {
        for view: UIView in self.subviews {
            view.removeFromSuperview()
        }
    }
}
