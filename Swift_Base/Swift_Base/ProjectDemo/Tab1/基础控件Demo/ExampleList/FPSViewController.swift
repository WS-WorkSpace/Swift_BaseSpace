//
//  FPSViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/10.
//

import UIKit
class FPSViewController: UIViewController {
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

    private lazy var fpsLabel = {
        #if DEBUG
        let fpsLab = FPSLabel(frame: CGRectMake(100, 100, 150, 50))
        let window = UIWindow.keyWindow
        window?.addSubview(fpsLab)
        fpsLab.snp.makeConstraints { make in
            guard let windowTemp = window else { return }
            make.top.equalTo(windowTemp).offset(distanceTop)
            make.left.equalTo(windowTemp).offset(10)
            make.size.equalTo(CGSizeMake(70, 30))
        }
        return fpsLab
        #endif
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // add mButton右触发一次,是否需要优化,
        mButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSizeMake(100, 50))
        }
    }

    @objc func fpsClickButton(btn: UIButton) {
        /// 由于只在debug测试模式下运行,window未释放造成的内存泄露暂时不管
        fpsLabel.frame = CGRectMake(100, 100, 150, 50)
        Lg.log("fpsClickButton")
    }
}
