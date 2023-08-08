//
//  WaterflowCollectionViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/8.
//

import CRRefresh
import UIKit

class WaterflowCollectionViewController: BaseViewController {
    private lazy var layout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 0
        $0.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    lazy var mCollectionView: UICollectionView = {
        let tempView = UICollectionView(frame: kScrollViewFrame, collectionViewLayout: layout)
        tempView.backgroundColor = .yellow
        return tempView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
}

extension WaterflowCollectionViewController {
    private func setupSubViews() {
        view.addSubview(mCollectionView)
    }

    /// 添加上拉刷新控件
    private func addHeadRefresh() {
        /// animator: 你的上拉刷新的Animator, 默认是 NormalHeaderAnimator
        mCollectionView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [weak self] in
            /// 开始刷新了
            /// 开始刷新的回调
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                /// 停止刷新
                self?.mCollectionView.cr.endHeaderRefresh()
            }
        }
        /// 手动刷新
        mCollectionView.cr.beginHeaderRefresh()
    }

    /// 添加下拉加载控件
    private func addFootRefresh() {
        /// animator: 你的下拉加载的Animator, 默认是NormalFootAnimator
        mCollectionView.cr.addFootRefresh(animator: NormalFooterAnimator()) { [weak self] in
            /// 开始下拉加载
            /// 回调
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                /// 结束加载
                self?.mCollectionView.cr.endLoadingMore()
                /// 没有更多数据
                self?.mCollectionView.cr.noticeNoMoreData()
                /// 复位
                self?.mCollectionView.cr.resetNoMore()
            }
        }
    }
}
