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
        let margin = 10.0 // 设置间距
        let maxCol = 3.0 // 设置列数
        // 设置item尺寸
        let itemW = (kScreenWidth - (maxCol + 1) * margin) / maxCol
        let itemH = itemW + 20
        $0.itemSize = CGSize(width: itemW, height: itemH) // 每个item的大小
        $0.minimumLineSpacing = margin // 设置最小行间距
        $0.minimumInteritemSpacing = margin // 最小列间距
        $0.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin) // 每组的四周位置间距 ,分别为上、左、下、右
        $0.scrollDirection = .vertical // 方向
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 0
        $0.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    lazy var mCollectionView: BaseCollectionView = {
        let tempView = BaseCollectionView(frame: kScrollViewFrame, collectionViewLayout: layout)
        tempView.delegate = self
        tempView.dataSource = self
        tempView.register(WaterflowCell.self, forCellWithReuseIdentifier: WaterflowCell.CellID)
        tempView.backgroundColor = .yellow
//        tempView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
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
        addHeadRefresh()
        addFootRefresh()
    }

    /// 添加上拉刷新控件
    private func addHeadRefresh() {
        /// animator: 你的上拉刷新的Animator, 默认是 NormalHeaderAnimator
        mCollectionView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [weak self] in
            /// 开始刷新了
            /// 开始刷新的回调
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                /// 结束加载
                self?.mCollectionView.cr.endLoadingMore()
                /// 没有更多数据
                self?.mCollectionView.cr.noticeNoMoreData()
//                /// 复位
                self?.mCollectionView.cr.resetNoMore()
            }
        }
    }
}

extension WaterflowCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WaterflowCell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterflowCell.CellID, for: indexPath) as! WaterflowCell
//        if indexPath.section == 0 {
//            if indexPath.row < 3 {
//                cell.imgView.kf.setImage(with: URL(string: imgs[indexPath.row]))
//            } else {
//                cell.imgView.kf.setImage(with: URL(string: "https://img03.sogoucdn.com/app/a/100520021/ff5eee1cac0eb94a99c92e3774d6c600"))
//            }
//
//        } else {
//            cell.imgView.kf.setImage(with: URL(string: imgs[indexPath.row]))
//        }

        return cell
    }
}

extension WaterflowCollectionViewController: UICollectionViewDelegate {}
