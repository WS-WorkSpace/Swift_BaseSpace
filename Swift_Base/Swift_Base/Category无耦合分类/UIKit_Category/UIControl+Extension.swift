//
//  UIControl+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/20.
//

import Foundation

private struct AssociateKeys {
    // 使用 ptr 进行操作
    static var closure = UnsafeRawPointer("UIControlclosure".withCString { $0 })
}

public extension UIControl {
    
    // MARK: 2.1、多少秒内不可重复点击
    // 多少秒内不可重复点击
    func preventDoubleHit(_ hitTime: Double = 1) {
        self.mPreventDoubleHit(hitTime)
    }
    
    /// UIControl 添加回调方式
    func addActionHandler(_ action: @escaping ControlClosure, for controlEvents: UIControl.Event = .touchUpInside) {
        self.addTarget(self, action: #selector(self.handleAction), for: controlEvents)
        objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
}

private var hitTimerKey: Void?
fileprivate extension UIControl  {
    
    private var hitTime: Double? {
        get {
            objc_getAssociatedObject(self, &hitTimerKey) as? Double
        }
        set {
            objc_setAssociatedObject(self, &hitTimerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func mPreventDoubleHit(_ hitTime: Double) {
        self.hitTime = hitTime
        addTarget(self, action: #selector(c_preventDoubleHit), for: .touchUpInside)
    }
    
    @objc func c_preventDoubleHit(_ base: UIControl)  {
        base.isUserInteractionEnabled = false
        RDAsync.asyncDelay(hitTime ?? 1.0) {
        } _: {
            base.isUserInteractionEnabled = true
        }
    }
    
    /// 点击回调
    @objc func handleAction(_ sender: UIControl) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ControlClosure {
            block(sender)
        }
    }
}
