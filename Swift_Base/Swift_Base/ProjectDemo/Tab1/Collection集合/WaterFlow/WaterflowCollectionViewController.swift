//
//  WaterflowCollectionViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/8.
//

import CRRefresh
import Kingfisher
import UIKit

let cellWidth: Double = 150
class WaterflowCollectionViewController: BaseViewController {
    var dataModelArray: [String] = []
    private lazy var layout = WaterFallFlowLayout().then {
        let margin: CGFloat = 10
        $0.minimumLineSpacing = margin
        $0.minimumInteritemSpacing = margin
        $0.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        $0.getHeightWithIndexBlock = { [weak self] mindexPath in
            guard let self = self else { return 0.0 }
            let isUserd = (self.itemCellHeight.count - 1) >= mindexPath.item
            return isUserd ? self.itemCellHeight[mindexPath.item] : 0.0
        }
    }

    var itemCellHeight: [Double] = []
    lazy var mCollectionView: BaseCollectionView = {
        let tempView = BaseCollectionView(frame: kScrollViewFrame, collectionViewLayout: layout)
        tempView.delegate = self
        tempView.dataSource = self
        tempView.register(WaterflowCell.self, forCellWithReuseIdentifier: WaterflowCell.CellID)
        tempView.backgroundColor = .yellow
//        tempView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        return tempView
    }()

    private lazy var waterModelHandle: WaterFallModelHandle = {
        var modelHandle = WaterFallModelHandle(delegate: self, itemWidth: cellWidth)
        return modelHandle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
}

// MARK: - Private扩展

extension WaterflowCollectionViewController {
    private func setupSubViews() {
        view.addSubview(mCollectionView)
        addHeadRefresh()
        addFootRefresh()
    }

    /// 添加上拉刷新控件
    private func addHeadRefresh() {
        /// animator: 你的上拉刷新的Animator, 默认是 NormalHeaderAnimator
        mCollectionView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [weak self] in
            guard let self = self else { return }
            /// 开始刷新了
            /// 开始刷新的回调
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                /// 停止刷新
                self.mCollectionView.cr.endHeaderRefresh()
                /// 清空数据,然后传入下拉数据,计算高度
                self.dataModelArray.removeAll()
                self.fetchNewData()
                self.waterModelHandle.computeNewData(urlArray: self.dataModelArray)
            }
        }
        /// 手动刷新
        mCollectionView.cr.beginHeaderRefresh()
    }

    /// 添加下拉加载控件
    private func addFootRefresh() {
        /// animator: 你的下拉加载的Animator, 默认是NormalFootAnimator
        mCollectionView.cr.addFootRefresh(animator: NormalFooterAnimator()) { [weak self] in
            guard let self = self else { return }
            /// 开始下拉加载
            /// 回调
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                /// 结束加载
                self.mCollectionView.cr.endLoadingMore()
                /// 没有更多数据
                self.mCollectionView.cr.noticeNoMoreData()
//                /// 复位
                self.mCollectionView.cr.resetNoMore()
                /// 传入下拉数据,计算高度
                self.fetchNewData()
                self.waterModelHandle.computeMoreData(urlArray: self.dataModelArray)
            }
        }
    }

    func fetchNewData() {
        let arrayTemp = ["https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F74%2F3c%2F7a%2F743c7a219e8882e12639d1145e07b8dc.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1669365649&t=66ad303aae6821418cf5408732c5be15",
                         "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fmobile%2F2020-02-28%2F5e58a039bfb07.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1669365649&t=7b0cb5e0037e13d4b69537ef1334d065",
                         "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fm00%2F97%2F17%2Fed95cf41b0b69084e46221c4a51afd18.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1669365649&t=49569f9112a25932bfc5f87f40fc0b57",
                         "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2Fdb%2F9a%2F31%2Fdb9a3144e5c4d932def647e4bcce4317.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1669365649&t=a0a9cdb112193ec1a675fe725b25b7a5",
                         "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F9%2Fab%2Fc39f307749.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1669365649&t=c2d0a4922920cbe68ca51f8ae24491c7",
                         "https://img0.baidu.com/it/u=1050592999,409280674&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=845",
                         "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F202006%2F15%2F20200615084805_gwjfg.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1669365649&t=3c0e0cbe05ec6c7bd4f6d3e413fc25e7"]
        dataModelArray += arrayTemp
    }
}

// MARK: - ModelHandle 数据处理回调

extension WaterflowCollectionViewController: WaterFallModelHandleDelegate {
    /// 下载图片计算高度的回调方法
    /// - Parameter imgHeights: 图片高度数组
    func notificationReloadWithWithItemHeights(imgHeights: [Double]) {
        itemCellHeight = imgHeights
        mCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension WaterflowCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataModelArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mCell: WaterflowCell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterflowCell.CellID, for: indexPath) as! WaterflowCell
        // 注：由于cell的复用，imageView的frame可能和cell对不上，需要重新设置。 或者layoutSubviews
//        mCell.setSubViewsFrame(rect: mCell.bounds)
        mCell.imgView.kf.setImage(with: URL(string: dataModelArray[indexPath.item]))
        return mCell
    }
}

// MARK: - UICollectionViewDelegate

extension WaterflowCollectionViewController: UICollectionViewDelegate {}
