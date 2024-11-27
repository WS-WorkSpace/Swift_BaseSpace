//
//  WaterflowCell.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/8.
//

import UIKit

class WaterflowCell: UICollectionViewCell {
    static let CellID = "WaterflowCell_CID"
    let bottomViewHeight: Double = 20.0
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 2
//        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var bottomView: UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .orange
        tempView.layer.cornerRadius = 2
//        tempView.clipsToBounds = true
        return tempView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgView)
        contentView.addSubview(bottomView)
//        setSubViewsFrame(rect: self.bounds)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setSubViewsFrame(rect: bounds)
    }

    func setSubViewsFrame(rect: CGRect) {
        imgView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height - bottomViewHeight)
        bottomView.frame = CGRectMake(0, imgView.RD_height, rect.size.width, bottomViewHeight)
//        imgView.snp.makeConstraints { make in
//            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
//        }
//        bottomView.snp.makeConstraints { make in
//            make.top.equalTo(contentView.RD_height-20)
//            make.left.equalTo(contentView).offset(0)
//            make.right.equalTo(contentView).offset(0)
//            make.size.equalTo(CGSizeMake(contentView.RD_width, 20))
//        }
    }
}
