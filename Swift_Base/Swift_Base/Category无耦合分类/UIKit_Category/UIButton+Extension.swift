//
//  UIButton+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/29.
//

// https://www.jianshu.com/p/c815c31eff71

import UIKit

extension UIButton {
    static func easyButton(_ title: String,
                            _ titleColor: UIColor = UIColor.white,
                            _ font: Double = 16.0,
                            _ frame: CGRect = CGRectZero,
                            _ block:@escaping ButtonCallBack) -> UIButton
    {
        let button = UIButton(frame: .zero)
        button.frame = frame
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setHandleClick(buttonCallBack: block)
        return button
    }

    static func creatButton(_ title: String,
                            _ titleColor: UIColor = UIColor.white,
                            _ font: Double = 16.0,
                            _ frame: CGRect,
                            _ target: Any,
                            _ action: Selector) -> UIButton
    {
        let button = UIButton(frame: .zero)
        button.frame = frame
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
//        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.randomColor.cgColor
//        button.backgroundColor = UIColor.randomColor
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    // MARK: 设置图片(通过Bundle加载)
    /// - Parameters:
    ///   - bundle: Bundle
    ///   - imageName: 图片名字
    ///   - state: 状态
    /// - Returns: 返回自身
    @discardableResult
    func image(in bundle: Bundle? = nil, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        setImage(image, for: state)
        return self
    }
    // MARK: 设置图片(通过Bundle加载)
    /// - Parameters:
    ///   - aClass: className bundle所在的类的类名
    ///   - bundleName: bundle 的名字
    ///   - imageName: 图片的名字
    ///   - state: 状态
    /// - Returns: 返回自身
    @discardableResult
    func image(forParent aClass: AnyClass, bundleName: String, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        guard let path = Bundle(for: aClass).path(forResource: bundleName, ofType: "bundle") else {
            return self
        }
        let image = UIImage(named: imageName, in: Bundle(path: path), compatibleWith: nil)
        setImage(image, for: state)
        return self
    }

}
// MARK: - 三、UIButton 图片 与 title 位置关系
/// UIButton 图片与title位置关系 https://www.jianshu.com/p/0f34c1b52604
public extension UIButton {
    
    /// 图片 和 title 的布局样式
    enum ImageTitleLayout {
        case imgTop
        case imgBottom
        case imgLeft
        case imgRight
    }
    
    // MARK: 3.1、设置图片和 title 的位置关系(提示：title和image要在设置布局关系之前设置)
    /// 设置图片和 title 的位置关系(提示：title和image要在设置布局关系之前设置)
    /// - Parameters:
    ///   - layout: 布局
    ///   - spacing: 间距
    /// - Returns: 返回自身
    @discardableResult
    func setImageTitleLayout(_ layout: ImageTitleLayout, spacing: CGFloat = 0) -> UIButton {
        switch layout {
        case .imgLeft:
            alignHorizontal(spacing: spacing, imageFirst: true)
        case .imgRight:
            alignHorizontal(spacing: spacing, imageFirst: false)
        case .imgTop:
            alignVertical(spacing: spacing, imageTop: true)
        case .imgBottom:
            alignVertical(spacing: spacing, imageTop: false)
        }
        return self
    }
    
    /// 水平方向
    /// - Parameters:
    ///   - spacing: 间距
    ///   - imageFirst: 图片是否优先
    private func alignHorizontal(spacing: CGFloat, imageFirst: Bool) {
        let edgeOffset = spacing / 2
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -edgeOffset,
                                            bottom: 0,right: edgeOffset)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset,
                                            bottom: 0, right: -edgeOffset)
        if !imageFirst {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
            self.imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
            self.titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
    }
    
    /// 垂直方向
    /// - Parameters:
    ///   - spacing: 间距
    ///   - imageTop: 图片是不是在顶部
    private func alignVertical(spacing: CGFloat, imageTop: Bool) {
        guard let imageSize = self.imageView?.image?.size,
              let text = self.titleLabel?.text,
              let font = self.titleLabel?.font
        else {
            return
        }
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let imageVerticalOffset = (titleSize.height + spacing) / 2
        let titleVerticalOffset = (imageSize.height + spacing) / 2
        let imageHorizontalOffset = (titleSize.width) / 2
        let titleHorizontalOffset = (imageSize.width) / 2
        let sign: CGFloat = imageTop ? 1 : -1
        
        self.imageEdgeInsets = UIEdgeInsets(top: -imageVerticalOffset * sign,
                                            left: imageHorizontalOffset,
                                            bottom: imageVerticalOffset * sign,
                                            right: -imageHorizontalOffset)
        self.titleEdgeInsets = UIEdgeInsets(top: titleVerticalOffset * sign,
                                            left: -titleHorizontalOffset,
                                            bottom: -titleVerticalOffset * sign,
                                            right: titleHorizontalOffset)
        // increase content height to avoid clipping
        let edgeOffset = (min(imageSize.height, titleSize.height) + spacing) / 2
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0, bottom: edgeOffset, right: 0)
    }
}

// MARK: - 五、Button的基本事件
private var buttonCallBackKey: Void?
typealias ButtonCallBack = ((UIButton?) -> ())
extension UIButton {

    internal var buttonCallBack: ButtonCallBack? {
        get { return objc_getAssociatedObject(self, &buttonCallBackKey) as? ButtonCallBack}
        set { objc_setAssociatedObject(self, &buttonCallBackKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    @objc internal func swiftButtonAction(_ button: UIButton) {
        self.buttonCallBack?(button)
    }
    // MARK: 5.1、button的事件
    /// button的事件
    /// - Parameters:
    ///   - controlEvents: 事件类型，默认是 valueChanged
    ///   - buttonCallBack: 事件
    /// - Returns: 闭包事件
    func setHandleClick(controlEvents: UIControl.Event = .touchUpInside, buttonCallBack: ((_ button: UIButton?) -> ())?){
        self.buttonCallBack = buttonCallBack
        self.addTarget(self, action: #selector(swiftButtonAction), for: controlEvents)
    }
}


// MARK: - Button扩大点击事件
private var UIButtonExpandSizeKey = UnsafeRawPointer("UIButtonExpandSizeKey".withCString { $0 })
public extension UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.touchExtendInset == .zero || isHidden || !isEnabled {
            return super.point(inside: point, with: event)
        }
        var hitFrame = bounds.inset(by: self.touchExtendInset)
        hitFrame.size.width = max(hitFrame.size.width, 0)
        hitFrame.size.height = max(hitFrame.size.height, 0)
        return hitFrame.contains(point)
    }
    
    // MARK: 扩大UIButton的点击区域，向四周扩展10像素的点击范围
    /// 扩大按钮点击区域 如UIEdgeInsets(top: -50, left: -50, bottom: -50, right: -50)将点击区域上下左右各扩充50
    /// 提示：theView 扩展点击相应区域时，其扩展的区域不能超过 superView 的 frame ，否则不会相应改点击事件；如果需要响应点击事件，需要对其 superView 进行和 theView 进行同样的处理
    var touchExtendInset: UIEdgeInsets {
        get {
            if let value = objc_getAssociatedObject(self, &UIButtonExpandSizeKey) {
                var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero
                (value as AnyObject).getValue(&edgeInsets)
                return edgeInsets
            } else {
                return UIEdgeInsets.zero
            }
        }
        set {
            objc_setAssociatedObject(self, &UIButtonExpandSizeKey, NSValue(uiEdgeInsets: newValue), .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}


/*
 private lazy var mButton = UIButton().then {
     let title = "UIButton"
     let titleColor = UIColor.randomColor
     $0.frame = .zero
     $0.titleLabel?.font = RD_Font(16)
     $0.setTitle(title, for: .normal)
     $0.setTitleColor(titleColor, for: .normal)
     $0.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
     $0.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
     $0.layer.cornerRadius = 5
     $0.layer.borderWidth = 1
     $0.layer.borderColor = UIColor.randomColor.cgColor
     $0.backgroundColor = UIColor.randomColor
     $0.addTarget(self, action: #selector(self.fpsClickButton(btn:)), for: .touchUpInside)
     view.addSubview($0)
 }
 */
