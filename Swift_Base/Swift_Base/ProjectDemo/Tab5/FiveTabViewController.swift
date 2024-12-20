//
//  FiveTabViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class FiveTabViewController: UIViewController {
    var txtUser: UITextField! // 用户名输入框
    var txtPwd: UITextField! // 密码输入款
    var formView: UIView! // 登陆框视图
    var horizontalLine: UIView! // 分隔线
    var confirmButton: UIButton! // 登录按钮
    var titleLabel: UILabel! // 标题标签
    var topConstraint: Constraint? // 登录框距顶部距离约束
    let keyboardHeight = 125
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.getViewLayer(borderWidth: 0.9, borderColor: .red, backgroundColor: .yellow)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 视图背景色
        self.view.backgroundColor = UIColor(red: 1/255, green: 170/255, blue: 235/255,
                                            alpha: 1)
        
        // MARK: - 布局

        /// 登陆整体布局3部分, 登录框formView / 登陆按钮confirmButton / 标题titleLabel
        /// 登录框formView 包括 账户/密码/分割线 3个子视图
        self.titleLabel = UILabel()
        self.titleLabel.text = "Apple.com"
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.systemFont(ofSize: 36)
        view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            // 存储top属性
            self.topConstraint = make.top.equalToSuperview().offset(kStatusBarHeight + 150).constraint
            make.centerX.equalToSuperview().offset(0)
            make.height.equalTo(44)
        }
        
        self.formView = UIView()
        self.formView.layer.borderWidth = 0.5
        self.formView.layer.borderColor = UIColor.lightGray.cgColor
        self.formView.backgroundColor = .white
        self.formView.layer.cornerRadius = 5
        self.view.addSubview(self.formView)
        self.formView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp_bottom).offset(50)
            make.centerX.equalToSuperview().offset(0)
            make.size.equalTo(CGSizeMake(240, 128))
        }
         
        // 分隔线
        self.horizontalLine = UIView()
        self.horizontalLine.backgroundColor = .lightGray
        self.formView.addSubview(self.horizontalLine)
        self.horizontalLine.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(self.formView).offset(10)
            make.height.equalTo(0.5)
        }
         
        // 密码图
        let imgLock1 = UIImageView(frame: CGRectMake(11, 11, 22, 22))
        imgLock1.image = UIImage(named: "tab5_select")
         
        // 密码图
        let imgLock2 = UIImageView(frame: CGRectMake(11, 11, 22, 22))
        imgLock2.image = UIImage(named: "home_ic_template_p")
         
        // 用户名输入框
        self.txtUser = UITextField()
        self.txtUser.delegate = self
        self.txtUser.placeholder = "用户名"
        self.txtUser.tag = 100
        self.txtUser.leftView = UIView(frame: CGRectMake(0, 0, 44, 44))
        self.txtUser.leftViewMode = UITextField.ViewMode.always
        self.txtUser.returnKeyType = UIReturnKeyType.next
         
        // 用户名输入框左侧图标
        self.txtUser.leftView!.addSubview(imgLock1)
        self.formView.addSubview(self.txtUser)
         
        // 布局
        self.txtUser.snp.makeConstraints { make in
            make.bottom.equalTo(self.horizontalLine).offset(-20)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
         
        // 密码输入框
        self.txtPwd = UITextField()
        self.txtPwd.delegate = self
        self.txtPwd.placeholder = "密码"
        self.txtPwd.tag = 101
        self.txtPwd.leftView = UIView(frame: CGRectMake(0, 0, 44, 44))
        self.txtPwd.leftViewMode = UITextField.ViewMode.always
        self.txtPwd.returnKeyType = UIReturnKeyType.next
         
        // 密码输入框左侧图标
        self.txtPwd.leftView!.addSubview(imgLock2)
        self.formView.addSubview(self.txtPwd)
         
        // 布局
        self.txtPwd.snp.makeConstraints { make in
            make.top.equalTo(self.horizontalLine).offset(20)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
         
        // 登录按钮
        self.confirmButton = UIButton()
        self.confirmButton.setTitle("登录", for: .normal)
        self.confirmButton.setTitleColor(.black, for: .normal)
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.backgroundColor = UIColor(red: 129/255.0, green: 214/255.0, blue: 246/255.0,
                                                     alpha: 0.5)
        self.confirmButton.addTarget(self, action: #selector(self.loginConfrim), for: .touchUpInside)
        self.view.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.titleLabel).offset(0)
            make.top.equalTo(self.formView.snp_bottom).offset(30)
            make.width.equalTo(self.formView.snp_width)
            make.height.equalTo(30)
        }
    }
     
    // 登录按钮点击
    @objc func loginConfrim() {
        // 收起键盘
        self.view.endEditing(true)
        // 视图约束恢复初始设置
        UIView.animate(withDuration: 0.3, animations: { () in
            self.topConstraint?.update(offset: kStatusBarHeight+150)
            self.view.layoutIfNeeded()
        })
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: { () in
            self.topConstraint?.update(offset: kStatusBarHeight+150)
            self.view.layoutIfNeeded()
        })
    }
    
}

extension FiveTabViewController: UITextFieldDelegate {
    // 输入框获取焦点开始编辑
    // 动画更新约束,键盘高度125
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: { () in
            self.topConstraint?.update(offset: kStatusBarHeight+150-125)
            self.view.layoutIfNeeded()
        })
    }

    // 输入框返回时操作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
        case 100:
            self.txtPwd.becomeFirstResponder()
        case 101:
            self.loginConfrim()
        default:
            print(textField.text as Any)
        }
        return true
    }
}
