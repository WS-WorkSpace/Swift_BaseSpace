//
//  WaterflowCell.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/8.
//

import SnapKit
import UIKit

class WaterflowCell: UICollectionViewCell {
    static let CellID = "WaterflowCell_CID"
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        return imageView
    }()

    lazy var bottomView: UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .orange
        tempView.layer.cornerRadius = 2
        tempView.clipsToBounds = true
        contentView.addSubview(tempView)
        return tempView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        }
        bottomView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        }
    }
}
