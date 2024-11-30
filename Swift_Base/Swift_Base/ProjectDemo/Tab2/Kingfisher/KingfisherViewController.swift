//
//  KingfisherViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/30.
//

import UIKit

class KingfisherViewController: UIViewController {

    
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var setImageButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let strURl = "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666#/"
        let imgURL = URL(string: strURl)
//        topImageView.kf.setImage(with: imgURL)
        
        ///设置完成处理闭包
//        topImageView.kf.setImage(with: imgURL) { result in
//            switch result {
//            case .success(let value):
//                print("Image downloaded: \(value.source.url?.absoluteString ?? "")")
//            case .failure(let error):
//                print("Image downloading failed: \(error)")
//            }
//        }
        if let cachedImage = ImageCache.default.retrieveImageInMemoryCache(forKey: strURl) {
            topImageView.image = cachedImage
            print("使用图片缓存")
        } else {
            topImageView.kf.setImage(with: URL(string: strURl))
            print("无缓存,网络获取")
        }
        clearCache()
    }
    // 清理图片缓存,机制待验证
    func clearCache(){
        ImageCache.default.clearMemoryCache() // 清理内存缓存
        ImageCache.default.clearDiskCache {
            print("清理完成")
        } // 清理磁盘缓存，完成后执行闭包
    }
    deinit {
        print("\(Self.self)已经释放")
    }
    
}
