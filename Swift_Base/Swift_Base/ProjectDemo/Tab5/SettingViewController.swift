//
//  SettingViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/31.
//

import UIKit

class SettingViewController: UIViewController {
    
    lazy var centerView = UIView()
    lazy var centerXView = UIView()
    lazy var topLeftView = UIView()
    lazy var topRightView = UIView()
    lazy var bottomLeftView = UIView()
    lazy var bottomRightView = UIView()
    
    lazy var view1 = UIView()
    lazy var view2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configUI()
    }
    
    private func configUI() {
        
        configSnapKit1()
        configSnapKit2()
        configSnapKit3()
        // 更新约束
        configSnapKit4()
    }
    
    // 实现居于当前视图的中心的视图布局，宽高为100，
    private func configSnapKit1() {
        self.view.addSubview(centerView)
        centerView.backgroundColor = RD_RandomColor()
        // makeConstraints 添加某个约束
        // updateConstraints 更新某个约束
        // removeConstraints 重置全部约束
        
        // 实现一
        centerView.snp.makeConstraints { (make) in
            make.width.equalTo(100)         // 宽为100
            make.height.equalTo(100)        // 高为100
            make.center.equalTo(view)       // 位于当前视图的中心
        }
        // 实现二 推荐
        centerView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)    // 链式语法直接定义宽高
            make.center.equalToSuperview()    // 直接在父视图居中
        }
        
        self.view.addSubview(centerXView)
        centerXView.backgroundColor = RD_RandomColor()
        centerXView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(15+distanceTop)
            make.height.equalTo(centerView.snp.height)
            make.width.equalToSuperview().multipliedBy(0.2) // 宽度为屏幕的0.2
            make.width.equalTo(centerView.snp.width).multipliedBy(0.5) // 宽度为中心view的0.5
        }
    }
    
    // 实现上下左右4个角添加4个视图，宽100，高50，间距15
    private func configSnapKit2() {
        self.view.addSubview(topLeftView)
        topLeftView.backgroundColor = RD_RandomColor()
        topLeftView.snp.makeConstraints { (make) in
            make.top.equalTo(15+distanceTop)
            make.left.equalTo(15)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
        self.view.addSubview(topRightView)
        topRightView.backgroundColor = RD_RandomColor()
        topRightView.snp.makeConstraints { (make) in
            make.top.equalTo(15+distanceTop)
            make.right.equalTo(-15)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
        self.view.addSubview(bottomLeftView)
        bottomLeftView.backgroundColor = RD_RandomColor()
        bottomLeftView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-15-kBottomSafeHeight)
            make.left.equalTo(15)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
        self.view.addSubview(bottomRightView)
        bottomRightView.backgroundColor = RD_RandomColor()
        bottomRightView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-15-kBottomSafeHeight)
            make.right.equalTo(-15)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
    }
    
    private func configSnapKit3() {
        // 中心view 内部添加子view
        centerView.addSubview(view1)
        view1.backgroundColor = RD_RandomColor()
        view1.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)      // 当前视图的顶部距离父视图的顶部：20（父视图顶部+20）
            make.left.equalToSuperview().offset(20)     // 当前视图的左边距离父视图的左边：20（父视图左边+20）
            make.bottom.equalToSuperview().offset(-20)  // 当前视图的底部距离父视图的底部：-20（父视图底部-20）
            make.right.equalToSuperview().offset(-20)
        }
        
        // view2距离centerView底部20，左侧对齐，宽度为一半，高度为一半
        self.view.addSubview(view2)
        view2.backgroundColor = RD_RandomColor()
        view2.snp.makeConstraints { (make) in
            make.left.equalTo(centerView.snp.left) // 左对齐
            make.top.equalTo(centerView.snp.bottom).offset(20) // 当前控件距离某控件的某位置距离
            make.width.equalTo(centerView.snp.width).multipliedBy(0.5)
            make.height.equalTo(centerView.snp.height).multipliedBy(0.5)
        }
    }
    
    // 更新约束
    private func configSnapKit4() {
        centerXView.snp.updateConstraints { (make) in
            make.top.equalTo(15+distanceTop+50) // 当前控件距离某控件的某位置距离
//            // 设置优先级的4中内置快捷方式
//            make.width.equalTo(50).priority(.required)
//            make.width.equalTo(100).priority(.high)
//            make.width.equalTo(200).priority(.medium)
//            make.width.equalTo(300).priority(.low)
        }
    }
 
}

