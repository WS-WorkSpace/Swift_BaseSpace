//
//  ExampleUI.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/3.
//

import UIKit

class ExampleUI_ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    lazy var subViewsWidth = 0.0
    lazy var customLabel: UILabel = .createCustomLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.subViewsWidth = kScreenWidth - 20
        navigationItem.title = "基础控件"
        self.setupSubviews()
    }

    func setupSubviews() {
        /// 视图 使用代码创建，frame 布局 ，不用去管 translatesAutoresizingMaskIntoConstraints
        /// 视图 使用代码创建，autolayout 布局，translatesAutoresizingMaskIntoConstraints 设置为 NO
        self.customLabel.text = "snp: label"
        self.customLabel.backgroundColor = UIColor.randomColor
        self.customLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.customLabel)
        self.customLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(distanceTop)
            make.left.equalTo(self.view).offset(10)
            make.size.equalTo(CGSize(width: self.subViewsWidth, height: 30))
        }
        
        self.view.addSubview(self.mLabel)
        self.view.addSubview(self.mView)
        self.view.addSubview(self.mButton)
        self.view.addSubview(self.mTextField)
        self.view.addSubview(self.pwdTextField)
        self.view.addSubview(self.mImageView)
        self.view.addSubview(self.mTextView)
        self.view.addSubview(self.mSwitch)
        self.view.addSubview(self.mSegment)
    }

    lazy var mLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = NSTextAlignment.center
        // customLabel.RD_y+customLabel.RD_height ,约束和frame布局选择一种
        label.frame = CGRect(x: 10, y: distanceTop+30+10, width: self.subViewsWidth, height: 30)
        label.text = "normal: label"
        label.textColor = .black
        label.backgroundColor = UIColor.randomColor
        return label
    }()
    
    lazy var mView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.randomColor
        view.frame = CGRect(x: 10, y: self.mLabel.frame.maxY+10, width: self.mLabel.frame.size.width, height: 30 * 3)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapClick(tap:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    // 手势事件
    @objc func tapClick(tap: UITapGestureRecognizer) {
        Lg.log("添加手势,单击一次")
    }
        
    lazy var mButton: UIButton = {
        let title = "这是UIButton"
        let titleColor = UIColor.randomColor
        
        let button = UIButton(frame: .zero)
        button.frame = CGRect(x: 10, y: self.mView.frame.maxY+10, width: self.mLabel.frame.size.width, height: 30)
        button.titleLabel?.font = RD_Font(16)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.randomColor.cgColor
        button.backgroundColor = UIColor.randomColor
        button.addTarget(self, action: #selector(self.ClickButton), for: .touchUpInside)
        return button
    }()
    
    @objc func ClickButton() {
        NSLog("点击按钮")
    }
    
    lazy var mTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.frame = CGRect(x: 10, y: self.mButton.frame.maxY+10, width: self.mLabel.frame.size.width, height: 30)
        textField.text = ""
        textField.placeholder = "这是UITextField"
        textField.font = RD_Font(15)
        textField.textColor = UIColor.randomColor
        textField.backgroundColor = BaseBgColor
        textField.textAlignment = .center
        textField.isEnabled = true
        textField.delegate = self
        return textField
    }()
    
    // MARK: - TextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let text = textField.text!
        Lg.log("mTextField 开始编辑 : \(text)")
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text!
        Lg.log("mTextField 文字改变 : \(text)")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text!
        Lg.log("mTextField 结束编辑 : \(text)")
    }
    
    lazy var pwdTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.frame = CGRect(x: 10, y: self.mTextField.frame.maxY+10, width: self.mLabel.frame.size.width, height: 30)
        textField.text = ""
        textField.font = RD_Font(15)
        textField.textColor = UIColor.randomColor
        textField.backgroundColor = BaseBgColor
        textField.textAlignment = .left
        textField.placeholder = "请输入6-16位字母、数字"
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        textField.isEnabled = true
        textField.addTarget(self, action: #selector(self.JhTextFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(self.JhTextFieldDidChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(self.JhTextFieldDidEndEditing(_:)), for: .editingDidEnd)
        return textField
    }()
    
    @objc private func JhTextFieldDidBeginEditing(_ textField: UITextField) {
        let text = textField.text!
        Lg.log("pwdTextField 开始编辑 : \(text)")
    }
    
    @objc private func JhTextFieldDidChange(_ textField: UITextField) {
        let text = textField.text!
        Lg.log("pwdTextField 文字改变 : \(text)")
    }
    
    @objc private func JhTextFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text!
        Lg.log("pwdTextField 结束编辑 : \(text)")
    }
    
    lazy var mImageView: UIImageView = {
        let image = UIImage(named: "AppIcon")
        
        let imageView = UIImageView(frame: .zero)
        imageView.frame = CGRect(x: (kScreenWidth - 50)/2, y: self.pwdTextField.frame.maxY+10, width: 50, height: 50)
        imageView.RD_centerX = self.view.RD_centerX
        imageView.image = image
        return imageView
    }()
    
    lazy var mTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.frame = CGRect(x: 10, y: self.mImageView.frame.maxY+10, width: self.mLabel.frame.size.width, height: 100)
        textView.text = "UITextView"
        textView.font = RD_Font(15)
        textView.textColor = UIColor.randomColor
        textView.backgroundColor = UIColor.randomColor
        textView.textAlignment = .left
        textView.isEditable = true
        textView.delegate = self
        return textView
    }()
    
    // MARK: - TextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let text = textView.text!
        Lg.log("textView 开始编辑 : \(text)")
    }

    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text!
        Lg.log("textView 文字改变 : \(text)")
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text!
        Lg.log("textView 结束编辑 : \(text)")
    }
    
    lazy var mSwitch: UISwitch = {
        let switchBtn = UISwitch(frame: .zero)
        switchBtn.frame = CGRect(x: (kScreenWidth - 30)/2, y: self.mTextView.frame.maxY+10, width: kScreenWidth, height: 30)
        switchBtn.isOn = true
        switchBtn.onTintColor = UIColor.randomColor
        return switchBtn
    }()
    
    lazy var mSegment: UISegmentedControl = {
        let dataArr = ["资料", "动态"]
        let segment = UISegmentedControl(items: dataArr)
        segment.frame = CGRect(x: 0, y: self.mSwitch.frame.maxY+10, width: 120, height: 30)
        segment.isMomentary = false
        segment.layer.cornerRadius = 5
        segment.clipsToBounds = true
        segment.tintColor = UIColor.rgbColor(237, 148, 45) // 选中颜色
        segment.backgroundColor = UIColor.grayColor(254)
        if #available(iOS 13.0, *) {
            // 文字默认颜色
            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
            // 文字选中颜色
            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow], for: .selected)
            // 选中item背景颜色
            segment.selectedSegmentTintColor = UIColor.rgbColor(237, 148, 45)
        }
        segment.selectedSegmentIndex = 0 // 选中第几个segment 一般用于初始化时选中
        segment.RD_centerX = self.view.RD_centerX
        segment.addTarget(self, action: #selector(self.SegmentChanged(segment:)), for: .valueChanged)
        segment.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
        return segment
    }()
    
    @objc func SegmentChanged(segment: UISegmentedControl) {
        let selectedIndex = segment.selectedSegmentIndex
        Lg.log("selectedIndex : \(selectedIndex)")
    }
}

extension UILabel {
    static func createCustomLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }
}
