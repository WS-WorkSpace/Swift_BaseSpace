//
//  ImageReusableView.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/7.
//

import UIKit

class ImageReusableView: UICollectionReusableView {
    static let CID = "ImageReusableView_CID"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.bg_imageView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 装饰视图
    private lazy var bg_imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "APP_NineGridHeadImg")
        imageView.frame = self.bounds
        return imageView
    }()

    /// 当布局更新时会调用这个方法，在这里更新UI
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        print("layoutAttributes.representedElementKind:", layoutAttributes.representedElementKind as Any)
        if layoutAttributes.representedElementKind == Self.CID {
            self.bg_imageView.isHidden = true
            if layoutAttributes.indexPath.section == 0 {
                self.backgroundColor = .green
            } else {
                self.backgroundColor = .yellow
            }
        }
    }
}
