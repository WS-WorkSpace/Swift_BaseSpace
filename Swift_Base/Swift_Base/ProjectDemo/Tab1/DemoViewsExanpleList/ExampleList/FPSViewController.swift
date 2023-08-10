//
//  FPSViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/10.
//

import SnapKit
import UIKit
class FPSViewController: BaseViewController {
//    private lazy var fpsButton = UIButton().then{
//        $0.backgroundColor = .yellow
//
//    }
    lazy var mButton: UIButton = {
        let title = "这是UIButton"
        let titleColor = RD_RandomColor()

        let button = UIButton(frame: .zero)
        button.frame = .zero
        button.titleLabel?.font = RD_Font(16)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = RD_RandomColor().cgColor
        button.backgroundColor = RD_RandomColor()
        button.addTarget(self, action: #selector(self.fpsClickButton(btn:)), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSizeMake(100, 50))
        }
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mButton.backgroundColor = .yellow
    }

    @objc func fpsClickButton(btn:UIButton) {
        Lg.log("fpsClickButton")
    }
}
