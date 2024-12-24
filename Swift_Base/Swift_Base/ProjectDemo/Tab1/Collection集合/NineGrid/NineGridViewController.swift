//
//  NineGridViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/5.
//

import UIKit

class NineGridViewController: BaseCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

//        modelArr = dataArr
    }

    func setupCollectionView() {
        customCellBlock = {  _, customCell in
            let cell = customCell as? BaseCollectionViewCell
            cell?.contentView.backgroundColor = UIColor.randomColor
        }

        /// 待完善,NineGridFlowLayout()失效
        collectionFlowLayout = NineGridFlowLayout()

        /// 仅用于测试,这里父类register后子类再register,覆盖了一层SectionHeader
        mCollectionView.register(ImageReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderViewID")

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            return CGSizeMake(150, 150)
        }
        return CGSizeMake(100, 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSizeMake(kScreenWidth, 150)
        }
        return CGSizeMake(kScreenWidth, 100)
    }
}
