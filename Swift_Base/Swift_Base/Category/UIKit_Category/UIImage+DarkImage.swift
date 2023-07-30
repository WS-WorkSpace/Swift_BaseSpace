//
//  UIImage+DarkImage.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit
extension UIImage {
    static func dynamicImage(_ lightImage: UIImage, _ darkImage: UIImage) -> UIImage {
        if #available(iOS 13.0, *) {
            let scaleTrait = UITraitCollection.current
            let darkUnscaledTrait = UITraitCollection(userInterfaceStyle: .dark)
            let darkScaledTrait = UITraitCollection(traitsFrom: [scaleTrait, darkUnscaledTrait])
            let img = lightImage.withConfiguration((lightImage.configuration?.withTraitCollection(UITraitCollection(userInterfaceStyle: .light)))!)
            let darkImg = darkImage.withConfiguration((darkImage.configuration?.withTraitCollection(UITraitCollection(userInterfaceStyle: .dark)))!)
            img.imageAsset?.register(darkImg, with: darkScaledTrait)
            return img
        } else {
            return lightImage
        }
    }
    
    /// 设置动态图片
    static func RD_dynamicImage(_ lightImage: String, _ darkImage: String) -> UIImage {
        if #available(iOS 13.0, *) {
            return UIImage.dynamicImage(UIImage(named: lightImage)!, UIImage(named: darkImage)!)
        }
        return UIImage(named: lightImage)!
    }
}
