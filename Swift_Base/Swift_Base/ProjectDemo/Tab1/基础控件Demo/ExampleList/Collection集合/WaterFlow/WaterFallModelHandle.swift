//
//  WaterFallModelHandle.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/8.
//

import Foundation
import Kingfisher

protocol WaterFallModelHandleDelegate: NSObjectProtocol {
    func notificationReloadWithWithItemHeights(imgHeights: [Double])
}

extension WaterFallModelHandleDelegate {
    func notificationReloadWithWithItemHeights(imgHeights: [Double]) {
        // 无delegate走option
    }
}

class WaterFallModelHandle {
    /// weak不能修饰非类的类型
    weak var delegate: WaterFallModelHandleDelegate?
    var itemWidth: Double = 100.0
    var widths: [String]?
    var heights: [Double] = []
    var allImageURLs: [String] = []
    var picImageArr: [UIImage] = []

    init(delegate: WaterFallModelHandleDelegate, itemWidth: Double) {
        self.delegate = delegate
        self.itemWidth = itemWidth
    }

    /// 加载新数据(下拉刷新)
    func computeNewData(urlArray: [String]) {
        self.allImageURLs = urlArray
        self.refresh(isloadNewData: true)
    }

    /// 加载更多数据(上拉刷新)
    func computeMoreData(urlArray: [String]) {
        self.allImageURLs = urlArray
        self.refresh(isloadNewData: false)
    }

    func refresh(isloadNewData: Bool) {
        if isloadNewData {
            self.heights.removeAll()
        }
        for i in 0 ..< self.allImageURLs.count {
            let urlString = self.allImageURLs[i]
            guard let url = URL(string: urlString) else { return }
            let resouce = ImageResource(downloadURL: url, cacheKey: urlString)
            KingfisherManager.shared.retrieveImage(with: resouce, options: nil, progressBlock: nil) {
                [weak self] img, _, _, url in
                guard let self = self else { return }
                if url?.absoluteString != urlString {
                    return
                }
                if self.heights.count == self.allImageURLs.count {
                    return
                }
                guard let image = img else { return }
                if self.picImageArr.count < self.allImageURLs.count {
                    self.picImageArr.append(image)
                }
                if self.heights.count < self.allImageURLs.count {
                    // 根据图片原始比例 计算 当前图片的高度(宽度固定)
                    let scale: Double = image.size.height / image.size.width
                    //                        CGFloat width = weakSelf.waterfallFlowLayout.itemWidth;
                    let ietmWidth: Double = self.itemWidth
                    let itemHeight: Double = ietmWidth * scale
                    self.heights.append(itemHeight)
                }
                if self.heights.count == self.allImageURLs.count {
                    // 赋值所有cell的高度数组itemHeights
                    // 赋值所有cell的高度数组itemHeights
                    //                if let mdelegare = self.delegate , mdelegare.responds(to: Selector.init("notificationReloadWithWithItemHeights:")) {
                    //                }
                    //                if let mdelegare = self.delegate , mdelegare.responds(toSelector: #selector(notificationReloadWithWithItemHeights(imgHeights:))) {
                    //                }
                    self.delegate?.notificationReloadWithWithItemHeights(imgHeights: self.heights)
                }
            }
        }
    }
}
