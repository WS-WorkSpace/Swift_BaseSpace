//
//  KingfisherViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/30.
//

import UIKit

class KingfisherViewController: UIViewController {
    let strURl = "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666#/"
    lazy var imgURL = URL(string: strURl)

    @IBOutlet var topImageView: UIImageView!

    @IBOutlet var botomImageView: UIImageView!

    @IBOutlet var setImageButton: UIButton!

    @IBAction func DownImageMethd(_ sender: UIButton) {
        mLog("点击按钮")
        /// 下载图片
        topImageView.backgroundColor = .randomColor
        downLoadImage(strURl)
    }

    @IBOutlet weak var downImgWithDelegate: UIButton!
    @IBAction func DimageWithDelegatButton(_ sender: Any) {
        botomImageView.backgroundColor = .randomColor
        downLoadImageWithDelegate(strURl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topImageView.backgroundColor = .lightGray
        botomImageView.backgroundColor = .lightGray

        // 更新XIB约束
        // 注意topImageView在xib约束中等级是.heigh = 750,我们想更新约束需要设置更高的 required = 1000
        // 最好还是xib和snap 同时用, 控制台输出警告
//        topImageView.backgroundColor = .green
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
    }

    // 清理图片缓存,机制待验证
    func clearCache() {
        ImageCache.default.clearMemoryCache() // 清理内存缓存
        ImageCache.default.clearDiskCache {
            print("清理完成")
        } // 清理磁盘缓存，完成后执行闭包
    }

    /// 下载图片, 闭包回调
    func downLoadImage(_ urlStr: String) {
        /// 下载图片
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
                self.topImageView.image = UIImage(data: value.originalData)
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

    /// 下载图片, 代理回调
    func downLoadImageWithDelegate(_ urlStr: String) {
        let url = URL(string: urlStr)
        guard let mURL = url else { return }
        ImageDownloader.default.delegate = self
        ImageDownloader.default.downloadImage(with: mURL, options: nil)
    }

    deinit {
        print("\(Self.self)已经释放")
    }
}

extension KingfisherViewController: ImageDownloaderDelegate {
    func imageDownloader(_ downloader: ImageDownloader, willDownloadImageForURL url: URL, with request: URLRequest?) {
        print("1 - 开始下载图片")
    }

    func imageDownloader(_ downloader: ImageDownloader, didFinishDownloadingImageForURL url: URL, with response: URLResponse?, error: Error?) {
        print("2 - 图片下载完成，开始处理图片")
    }

    func imageDownloader(_ downloader: ImageDownloader, didDownload data: Data, for url: URL) -> Data? {
        print("3 - 以二进制表示的图片")
        print(data) // 32226 bytes
        return data
    }

    // 如果我们只需要结果，那么我们只实现最后一个协议就可以
    func imageDownloader(_ downloader: ImageDownloader, didDownload image: Image, for url: URL, with response: URLResponse?) {
        print("4 - 最终的图片")
        print(Thread.current) // <NSThread: 0x60000173ac80>{number = 5, name = (null)}
        // 注意我们当前是子线程,需要回到主线程更新UI
        DispatchQueue.main.async {
            self.botomImageView.image = image
        }
        print(image) // <UIImage:0x6000030314d0 anonymous {500, 666} renderingMode=automatic(original)>
    }
}

/**
 https://www.jianshu.com/p/623acaf06f97
 一、老生长谈的group enter、group level
 由于Kingfisher里图片加载都是异步操作，我们希望可以监测到所有图片都加载完毕然后给一个回调，这其实就是多个异步任务的同步处理操作，而iOS里比较常用的也就是gcd里的信号量和group enter、group level了
 1单张图片加载方法，这里我们使用的是retrieveImage方法，这个方法会先从内存/硬盘缓存里查找图片，如果找到会直接返回，找不到则去加载并缓存图片资源。
 static func downloadWith(urlStr: String, complete: ((UIImage?) -> ())? = nil) {
        if let url = URL(string: urlStr) {
            KingfisherManager.shared.retrieveImage(with: url) { (result) in
                switch result {
                case .success(let imgResult):
                    complete?(imgResult.image)
                case .failure(let error):
                    print(error)
                    complete?(nil)
                }
            }
        } else {
            complete?(nil)
        }
    }
 2今天的多张图片加载，这里使用的是dispatchgroup的enter、level来进行同步处理的。（我这边的需求是只要一张下载失败就直接返回，但是没有找到提前终止group或者释放的相关方法，这里处理是如果有下载失败直接回调，并将闭包置空）

 static func downloadWith(urlStrArray: [String], complete: @escaping AIKingfisherDownLoadResultBlock) {
        let group = DispatchGroup()
        let queue = DispatchQueue.main
        var imgDic = [String: UIImage]()
        var downLoadCount = 0
        var block: AIKingfisherDownLoadResultBlock? = complete
        for urlStr in urlStrArray {
            group.enter()
            queue.async(group: group) {
                AIKingfisher.downloadWith(urlStr: urlStr) { (image) in
                    if let img = image {
                        imgDic.updateValue(img, forKey: urlStr)
                        downLoadCount = downLoadCount + 1
                    } else { //有一个下载失败就提前终止
                        block?(nil)
                        block = nil
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: queue) {
            if downLoadCount != urlStrArray.count {
                block?(nil)
            } else {
                block?(AIKingfisherDownLoadResult(imgDic: imgDic))
            }
        }
    }
 3、另外一种写法（使用group.wait设置超时时间，但要注意这个方法会阻塞当前线程所以不能放在主线程调用）

 /// Kingfisher多图下载
     /// - Parameter urlStrArray: 图片链接str数组
     /// - Parameter timeout: 超时时间
     /// - Parameter complete: 回调
     static func downloadWith(urlStrArray: [String], timeout: TimeInterval = 10, complete: @escaping (AIKingfisherDownLoadResult?) -> ()) {
         let group = DispatchGroup()
         let queue = DispatchQueue.main
         var imgDic = [String: UIImage]()
         var downLoadCount = 0
         for urlStr in urlStrArray {
             group.enter()
             queue.async(group: group) {
                 AIKingfisher.downloadWith(urlStr: urlStr) { (image) in
                     if let img = image {
                         imgDic.updateValue(img, forKey: urlStr)
                         downLoadCount = downLoadCount + 1
                     }
                     group.leave()
                 }
             }
         }
         DispatchQueue.global().async {
             let result = group.wait(timeout: DispatchTime.now() + timeout)
             DispatchQueue.main.async {
                 switch result {
                 case .success:
                     if downLoadCount != urlStrArray.count {
                         complete(nil)
                     } else {
                         complete(AIKingfisherDownLoadResult(imgDic: imgDic))
                     }
                 case .timedOut:
                     AILog("下载超时")
                     complete(nil)
                 }
             }
         }
     }

 */
