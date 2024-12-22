//
//  ButtonExampleViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/22.
//

import UIKit

class ButtonExampleViewController: UIViewController {
    var btnZero: UIButton?
    var btnOne: UIButton?
    var btnTwo: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // MARK: - 简单创建个按钮

        let easyBtn = UIButton.easyButton("简单Btn") { btn in
            btn?.backgroundColor = UIColor.randomColor
            mlog("点击了按钮easyBtn")
        }
        easyBtn.backgroundColor = .cyan
        view.addSubview(easyBtn)
        easyBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(200, 100))
            make.top.equalTo(view).offset(distanceTop + 30)
            make.centerX.equalToSuperview()
        }
        btnZero = easyBtn

        // MARK: - 调整按钮位置

        let easyBtn1 = UIButton.easyButton("简单Btn2") { btn in
            btn?.backgroundColor = UIColor.randomColor
            mlog("点击了按钮easyBtn1")
        }
        easyBtn1.setImage(UIImage(named: "Alert_success"), for: .normal)
        // 如果你的按钮时是selected状态，点击进入高亮状态，展示的并不是你需要的图片，此时就需要设置.selected | .highlighted这种状态的图片了。
        easyBtn1.setImage(UIImage(named: "Alert_error"), for: .selected)

        easyBtn1.backgroundColor = UIColor.lightGray
        view.addSubview(easyBtn1)
        easyBtn1.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(200, 100))
            make.top.equalTo(easyBtn.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        // subviews只有UIButtonLabel,只有UIButtonLabel是可以遍历出来的
        // 只有完成了easyBtn1的渲染,比如在easyBtn2后面遍历subviews才可以遍历出imageview
        // 所以我们选择在viewDidAppear测试所有的subviews
        // easyBtn1.getViewLayer(borderWidth: 1, borderColor: .red, backgroundColor: .green)

        // 修改位置需要修改imageEdgeInsets和titleEdgeInsets
        easyBtn1.setImageTitleLayout(.imgTop, spacing: 15)
        btnOne = easyBtn1

        // MARK: - 扩大点击范围

        // 因为重写func point() -> Bool方法,会自定调用重写的point()
        // 然后判断扩展属性touchExtendInset是否需要变化
        // -50表示扩张50
        let easyBtn2 = UIButton.easyButton("简单Btn3") { btn in
            btn?.backgroundColor = UIColor.randomColor
            mlog("点击了按钮easyBtn2")
        }
        easyBtn2.setImage(UIImage(named: "Alert_warning"), for: .normal)
        easyBtn2.backgroundColor = .randomColor
        view.addSubview(easyBtn2)
        easyBtn2.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(200, 100))
            make.top.equalTo(easyBtn1.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        // 修改位置需要修改imageEdgeInsets和titleEdgeInsets
        easyBtn2.setImageTitleLayout(.imgBottom, spacing: 0)
        easyBtn2.touchExtendInset = UIEdgeInsets(top: -50, left: -50, bottom: -50, right: -50)
        btnTwo = easyBtn2
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        btnOne?.getViewLayer(borderWidth: 1, borderColor: .red, backgroundColor: .green)
        btnTwo?.getViewLayer(borderWidth: 1, borderColor: .red, backgroundColor: .green)
    }
}
