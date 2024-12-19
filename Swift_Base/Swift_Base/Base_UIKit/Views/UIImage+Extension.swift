//
//  UIImage+Extension.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit
import Photos

extension UIImage {
    /// 纯色图颜色重绘（更改图片颜色）
    /// - Parameter color: 目标颜色
    /// - Returns: 重绘颜色后的Image
    public func RD_imageWithTintColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        tintColor.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }

    /// 创建指定颜色的图像
    static func RD_imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
extension UIImage {
    
    // MARK: 1.15、保存图片到相册(建议使用这个)
    /// 保存图片到相册
    func savePhotosImageToAlbum(completion: @escaping ((Bool, Error?) -> Void)) {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: self)
        } completionHandler: { (isSuccess: Bool, error: Error?) in
            completion(isSuccess, error)
        }
    }
}
