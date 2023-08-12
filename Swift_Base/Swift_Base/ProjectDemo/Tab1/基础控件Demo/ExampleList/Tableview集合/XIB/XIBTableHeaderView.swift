//
//  XIBTableHeaderView.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/11.
//

import UIKit

class XIBTableHeaderView: UIView {
    
    @IBOutlet weak var RightButton: UIButton!
    
    @IBOutlet weak var leftImge: UIImageView!
    
    @IBAction func rightBtnMethod(_ sender: UIButton) {
        self.headerClickRightBtnBlock()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    let headerClickRightBtnBlock: () -> Void = {
        print("点击按钮了！")
    }
    
    func initUI() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapImageView))
        leftImge.addGestureRecognizer(tapGesture)
        leftImge.isUserInteractionEnabled = true
    }
    @objc func tapImageView(){
        print("视图被点击")
    }

}
