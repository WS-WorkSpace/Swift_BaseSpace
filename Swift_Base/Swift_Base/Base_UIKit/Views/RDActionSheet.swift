//
//  RDActionSheet.swift
//  Swift_Base
//
//  Created by RD on 2023/3/29.
//  仿微信底部弹框

import UIKit

class RDActionSheet: UIView {
    let kRowHeight = 48.0
    let kRowLineHeight = 1.0
    let kSeparatorHeight = 6.0
    let kTitleFontSize = 13.0
    let kLargeTitleFontSize = 19.0
    let kButtonTitleFontSize = 18.0
    let kAnimateDuration = 0.3
    
    let kBgColor = DynamicColor(UIColor.white, UIColor.grayColor(44))
    let kTitleColor = DynamicColor(UIColor.grayColor(135), BaseLabelColor)
    let kLargeTitleColor = DynamicColor(UIColor.grayColor(64), UIColor.white)
    let kBtnTitleColor = DynamicColor(UIColor.grayColor(64), BaseLabelColor)
    let kSeparatorColor = DynamicColor(UIColor.grayColor(238), UIColor.grayColor(35))
    
    var backgroundView = UIView()
    var actionSheetView = UIView()
    
    typealias ActionSheetBlock = (Int) -> Void
    
    var actionSheetBlock: ActionSheetBlock?
    
    /// 仿微信底部弹框
    /// - Parameters:
    ///   - title: 标题
    ///   - description: 描述信息
    ///   - actionTitles: 可选择点击的按钮文字（不包括取消）
    ///   - destructive: 红色文字
    ///   - cancelTitle: 取消按钮文字
    ///   - actionSheetBlock: 点击按钮之后的回调（取消按钮的index 为 0 ，红色文字： -1，其他按钮的index从上往下依次为 1、2、3...）
    class func show(title: String = "", largeTitle: String = "", actionTitles: [String] = [], destructive: String = "", cancelTitle: String = "取消", handler actionSheetBlock: @escaping ActionSheetBlock) {
        let ActionSheet = RDActionSheet(title: title, largeTitle: largeTitle, actionButtonTitles: actionTitles, destructiveButtonTitle: destructive, cancelButtonTitle: cancelTitle, handler: actionSheetBlock)
        ActionSheet.show()
    }
}

extension RDActionSheet {
    convenience init(title: String?, largeTitle: String?, actionButtonTitles: [String]?, destructiveButtonTitle: String?, cancelButtonTitle: String?, handler actionSheetBlock: @escaping ActionSheetBlock) {
        self.init()
        
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.actionSheetBlock = actionSheetBlock
        var actionSheetHeight: CGFloat = 0
        
        backgroundView = UIView(frame: frame)
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.backgroundColor = UIColor.rgbColor(0, 0, 0, 0.4)
        backgroundView.alpha = 0
        addSubview(backgroundView)
        
        actionSheetView = UIView(frame: CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 0))
        actionSheetView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        actionSheetView.backgroundColor = kSeparatorColor
        addSubview(actionSheetView)
        
        let normalImage = UIImage.dynamicImage(UIImage.RD_imageWithColor(UIColor.white), UIImage.RD_imageWithColor(UIColor.grayColor(44)))
        let highlightedImage = UIImage.dynamicImage(UIImage.RD_imageWithColor(UIColor.grayColor(242)), UIImage.RD_imageWithColor(UIColor.grayColor(64)))
        
        if !title!.isEmpty {
            actionSheetHeight += kRowLineHeight
            
            var viewHeight = 30.0
            let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: viewHeight))
            view.backgroundColor = kBgColor
            actionSheetView.addSubview(view)
            
            let titleHeight: CGFloat = ceil(title!.RD_getStringHeight(frame.size.width - 60.0, kTitleFontSize))
            let titleLabel = UILabel(frame: CGRect(x: 30, y: 0, width: frame.size.width - 60.0, height: titleHeight + viewHeight + 1))
            titleLabel.autoresizingMask = .flexibleWidth
            titleLabel.text = title
            titleLabel.backgroundColor = kBgColor
            titleLabel.textColor = kTitleColor
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: kTitleFontSize)
            titleLabel.numberOfLines = 0
            view.addSubview(titleLabel)
            
            if !largeTitle!.isEmpty {
                let largeTitleHeight: CGFloat = ceil(largeTitle!.RD_getStringHeight(frame.size.width, kLargeTitleFontSize))
                let largeTitleLabel = UILabel(frame: CGRect(x: 0, y: 15, width: frame.size.width, height: largeTitleHeight))
                largeTitleLabel.autoresizingMask = .flexibleWidth
                largeTitleLabel.text = largeTitle
                largeTitleLabel.backgroundColor = kBgColor
                largeTitleLabel.textColor = kLargeTitleColor
                largeTitleLabel.textAlignment = .center
                largeTitleLabel.font = UIFont.systemFont(ofSize: kLargeTitleFontSize)
                largeTitleLabel.numberOfLines = 0
                view.addSubview(largeTitleLabel)
                
                titleLabel.frame = CGRect(x: 0, y: largeTitleLabel.frame.maxY + 3, width: frame.size.width, height: titleHeight)
                viewHeight = viewHeight + largeTitleHeight + titleHeight + 1
                view.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: viewHeight + 1)
                actionSheetHeight += viewHeight
            } else {
                viewHeight = viewHeight + titleHeight
                view.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: viewHeight + 1)
                actionSheetHeight += viewHeight
            }
        }
        if !actionButtonTitles!.isEmpty {
            for i in 0 ..< actionButtonTitles!.count {
                actionSheetHeight += kRowLineHeight
                let button = UIButton(type: .custom)
                button.frame = CGRect(x: 0, y: actionSheetHeight, width: frame.size.width, height: kRowHeight)
                button.autoresizingMask = .flexibleWidth
                button.tag = i + 1
                button.titleLabel?.font = UIFont.systemFont(ofSize: kButtonTitleFontSize)
                button.setTitle(actionButtonTitles?[i], for: .normal)
                button.setTitleColor(kBtnTitleColor, for: .normal)
                button.setBackgroundImage(normalImage, for: .normal)
                button.setBackgroundImage(highlightedImage, for: .highlighted)
                button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                actionSheetView.addSubview(button)
                actionSheetHeight += kRowHeight
            }
        }
        if !destructiveButtonTitle!.isEmpty {
            actionSheetHeight += kRowLineHeight
            let destructiveButton = UIButton(type: .custom)
            destructiveButton.frame = CGRect(x: 0, y: actionSheetHeight, width: frame.size.width, height: kRowHeight)
            destructiveButton.autoresizingMask = .flexibleWidth
            destructiveButton.tag = -1
            destructiveButton.titleLabel?.font = UIFont.systemFont(ofSize: kButtonTitleFontSize)
            destructiveButton.setTitle(destructiveButtonTitle, for: .normal)
            destructiveButton.setTitleColor(UIColor.rgbColor(230, 66, 66), for: .normal)
            destructiveButton.setBackgroundImage(normalImage, for: .normal)
            destructiveButton.setBackgroundImage(highlightedImage, for: .highlighted)
            destructiveButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            actionSheetView.addSubview(destructiveButton)
            actionSheetHeight += kRowHeight
        }
        if !cancelButtonTitle!.isEmpty {
            actionSheetHeight = actionSheetHeight + kSeparatorHeight
            let cancelButton = UIButton(type: .custom)
            cancelButton.frame = CGRect(x: 0, y: actionSheetHeight, width: frame.size.width, height: kRowHeight)
            cancelButton.autoresizingMask = .flexibleWidth
            cancelButton.tag = 0
            cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: kButtonTitleFontSize)
            cancelButton.setTitle(cancelButtonTitle ?? "取消", for: .normal)
            cancelButton.setTitleColor(kBtnTitleColor, for: .normal)
            cancelButton.setBackgroundImage(normalImage, for: .normal)
            cancelButton.setBackgroundImage(highlightedImage, for: .highlighted)
            cancelButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            actionSheetView.addSubview(cancelButton)
            actionSheetHeight += kRowHeight
        }
        actionSheetView.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: actionSheetHeight + SAFEAREA_BOTTOM())
        actionSheetView.RD_addCorner(conrners: [.topLeft, .topRight], radius: 10)
    }
    
    private func show() {
        // 在主线程中处理,否则在viewDidLoad方法中直接调用,会先加本视图,后加控制器的视图到UIWindow上,导致本视图无法显示出来,这样处理后便会优先加控制器的视图到UIWindow上
        OperationQueue.main.addOperation {
            let frontToBackWindows = (UIApplication.shared.windows as NSArray).reverseObjectEnumerator()
            for window in frontToBackWindows {
                let windowOnMainScreen = (window as AnyObject).screen == UIScreen.main
                let windowIsVisible = !(window as AnyObject).isHidden && (window as AnyObject).alpha > 0
                let windowLevelNormal = (window as AnyObject).windowLevel == .normal
                if windowOnMainScreen, windowIsVisible, windowLevelNormal {
                    (window as AnyObject).addSubview(self)
                    break
                }
            }
            UIView.animate(withDuration: self.kAnimateDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: { [self] in
                backgroundView.alpha = 1.0
                actionSheetView.frame = CGRect(x: 0, y: frame.size.height - actionSheetView.frame.size.height, width: frame.size.width, height: actionSheetView.frame.size.height)
            })
        }
    }
    
    private func dismiss() {
        UIView.animate(withDuration: kAnimateDuration, delay: 0, options: .curveEaseInOut, animations: { [self] in
            backgroundView.alpha = 0.0
            actionSheetView.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: actionSheetView.frame.size.height)
        }) { [self] _ in
            removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: backgroundView)
        if !actionSheetView.frame.contains(point ?? CGPoint.zero) {
            if actionSheetBlock != nil {
                actionSheetBlock?(0)
            }
            dismiss()
        }
    }
    
    @objc private func buttonClicked(_ button: UIButton?) {
        if actionSheetBlock != nil {
            actionSheetBlock?(button!.tag)
        }
        dismiss()
    }
}
