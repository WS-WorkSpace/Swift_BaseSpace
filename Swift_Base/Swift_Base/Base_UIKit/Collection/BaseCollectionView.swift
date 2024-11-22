//
//  BaseCollectionView.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/4.
//

import UIKit

class BaseCollectionView: UICollectionView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect, collectionViewLayout:UICollectionViewLayout){
        super.init(frame:frame, collectionViewLayout:collectionViewLayout)
        config()
    }
    private func config() {
        self.backgroundColor = .white
        self.showsVerticalScrollIndicator = false
        self.alwaysBounceVertical = true
    }
}
