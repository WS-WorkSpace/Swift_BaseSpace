//
//  KingfisherViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/30.
//

import UIKit

class KingfisherViewController: UIViewController {
    @IBOutlet var topImageView: UIImageView!

    @IBOutlet var botomImageView: UIImageView!

    @IBOutlet var setImageButton: UIButton!

    @IBAction func DownImageMethd(_ sender: UIButton) {
        mLog("点击按钮")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let strURl = "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666#/"
        let imgURL = URL(string: strURl)
        // 更新XIB约束
        // 注意topImageView在xib约束中等级是.heigh = 750,我们想更新约束需要设置更高的 required = 1000
        topImageView.backgroundColor = .green
//        topImageView.snp.updateConstraints { make in
//            make.size.equalTo(CGSizeMake(300, 150)).priority(.required)
//            make.top.equalTo(view).offset(distanceTop + 10)
//        }

        topImageView.kf.setImage(with: imgURL)
        /// 置完成的回调
        /**
         topImageView.kf.setImage(with: imgURL) { result in
             switch result {
             case .success(let value):
                 print("Image downloaded: \(value.source.url?.absoluteString ?? "")")
             case .failure(let error):
                 print("Image downloading failed: \(error)")
             }
         }
          */
        /// 使用缓存
        /**
         if let cachedImage = ImageCache.default.retrieveImageInMemoryCache(forKey: strURl) {
             topImageView.image = cachedImage
             print("使用图片缓存")
         } else {
             topImageView.kf.setImage(with: URL(string: strURl))
             print("无缓存,网络获取")
         }
          **/
        /// 清理缓存
        /// clearCache()

        /// 下载图片
//        botomImageView.backgroundColor = .randomColor
//        downLoadImage(strURl)

    }

    // 清理图片缓存,机制待验证
    func clearCache() {
        ImageCache.default.clearMemoryCache() // 清理内存缓存
        ImageCache.default.clearDiskCache {
            print("清理完成")
        } // 清理磁盘缓存，完成后执行闭包
    }
    /// 下载图片
    func downLoadImage(_ urlStr:String){
        /// 下载图片
        botomImageView.backgroundColor = .randomColor
        let url = URL(string: urlStr)
        ImageDownloader.default.downloadImage(with: url!, options: nil) { receivedSize, totalSize in
            print("已下载:\(receivedSize)")
            print("下载总量:\(totalSize)")
            print("下载进度\(receivedSize / totalSize)")
        } completionHandler: {
//            (Result<ImageLoadingResult, KingfisherError>) -> Void)?
            result in
            switch result {
            case .success(let value):
//                self.botomImageView.image = value.image
                self.botomImageView.image = UIImage(data: value.originalData)
                print(value.image.cgImage ?? "")
                print(value.image.size) // (500.0, 666.0)
                print(value.image.scale) // 1.0
                if #available(iOS 13.0, *) {
                    print(value.image.configuration as Any) // Optional(<UIImageConfiguration:0x6000002b0aa0 traits=(DisplayScale = 1)>)
                }
                print(value.image.imageOrientation) // UIImageOrientation
                print(value.url ?? "")
                print(value.originalData) // 32226 bytes

            case .failure(let error):
                print(error)
            }
        }
    }

    deinit {
        print("\(Self.self)已经释放")
    }
}
class GGImageDownloader: ImageDownloaderDelegate {
    static let shared = GGImageDownloader()
//    func imageDownloader(_ downloader: ImageDownloader, willDownloadImageForURL url: URL, with request: URLRequest?) {
//        print("1 - 开始下载图片")
//    }
//    
//    func imageDownloader(_ downloader: ImageDownloader, didFinishDownloadingImageForURL url: URL, with response: URLResponse?, error: Error?) {
//        print("2 - 图片下载完成，开始处理图片")
//    }
//    func imageDownloader(_ downloader: ImageDownloader, didDownload data: Data, for url: URL) -> Data? {
//        print("3 - 以二进制表示的图片")
//        print(data) // 例如 1912 bytes
//        return data
//    }
//    // 如果我们只需要结果，那么我们只实现最后一个协议就可以
//    func imageDownloader(_ downloader: ImageDownloader, didDownload image: Image, for url: URL, with response: URLResponse?) {
//        print("4 - 最终的图片")
//        print(image) // 例如 <UIImage: 0x6000030064c0>, {260, 55}
//    }
    
}


