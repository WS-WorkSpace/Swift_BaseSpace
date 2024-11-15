//
//  BackImageSectionContentCell.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/7.
//

import SnapKit
import UIKit
class ContentCell: UICollectionViewCell {
    static let COMMONEPRODUCT_CID = "COMMONEPRODUCT_CID"
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        imgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
