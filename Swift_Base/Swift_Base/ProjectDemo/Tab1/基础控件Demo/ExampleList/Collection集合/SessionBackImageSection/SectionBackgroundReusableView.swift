//
//  BaseSectionBackgroundReusableView.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/6.
//

import Kingfisher
import UIKit

class SectionBackgroundReusableView: UICollectionReusableView {
    static let BACKGAROUND_CID = "BACKGAROUND_CID"

    private lazy var bg_imageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        bg_imageView.frame = bounds
        guard let att = layoutAttributes as? SectionDecorationViewCollectionViewLayoutAttributes else {
            return
        }
        backgroundColor = UIColor.clear
        bg_imageView.layer.cornerRadius = 5
        bg_imageView.clipsToBounds = true
        bg_imageView.backgroundColor = att.backgroundColor
        guard let imageName = att.imageName else {
            bg_imageView.image = nil
            return
        }
        guard let image_url = URL(string: imageName) else {
            return
        }
        bg_imageView.kf.setImage(with: image_url)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// section装饰背景的布局属性
class SectionDecorationViewCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    // 装饰背景图片
    var imageName: String?
    // 背景色
    var backgroundColor = UIColor.white

    /// 所定义属性的类型需要遵从 NSCopying 协议
    /// - Parameter zone:
    /// - Returns:
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! SectionDecorationViewCollectionViewLayoutAttributes
        copy.imageName = imageName
        copy.backgroundColor = backgroundColor
        return copy
    }

    /// 所定义属性的类型还要实现相等判断方法（isEqual）
    /// - Parameter object:
    /// - Returns: 是否相等
    override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? SectionDecorationViewCollectionViewLayoutAttributes else {
            return false
        }
        if imageName != rhs.imageName {
            return false
        }
        if !backgroundColor.isEqual(rhs.backgroundColor) {
            return false
        }
        return super.isEqual(object)
    }
}
