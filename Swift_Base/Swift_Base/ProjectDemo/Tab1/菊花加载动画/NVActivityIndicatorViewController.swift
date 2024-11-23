//
//  NVActivityIndicatorViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/23.
//

import NVActivityIndicatorView
import UIKit

class NVActivityIndicatorViewController: BaseViewController {
    var activityIndicatorView:NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        /// 菊花测试
        self.activityIndicatorTest()
        /// 3秒后关系
        self.perform(#selector(self.stop), with: "Stop", afterDelay: 3.0)
    }

    func activityIndicatorTest() {
        activityIndicatorView = NVActivityIndicatorView(frame: CGRectMake(100, 100, 50, 50), type: NVActivityIndicatorType.circleStrokeSpin, color: .blue, padding: 0)
        activityIndicatorView.startAnimating()
        //        NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD = 20
        view.addSubview(activityIndicatorView)

        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }

    @objc func stop() {
        print("动画停止")
        activityIndicatorView.stopAnimating()
    }
}
