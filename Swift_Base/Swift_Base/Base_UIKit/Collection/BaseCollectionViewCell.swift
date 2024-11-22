//
//  BaseCollectionViewCell.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/4.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    private var textLabel: UILabel!
    
    var cellIndex: Int = 0 {
        didSet {
            textLabel.text = "\(cellIndex)"
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 30)
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
        backgroundColor = .orange
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = bounds
    }
    
    // 设置选中背景色
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .lightGray
            } else {
                contentView.backgroundColor = nil
            }
            super.isSelected = isSelected
        }
    }
    
    // 设置高亮色
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                contentView.backgroundColor = .purple
            } else {
                contentView.backgroundColor = nil
            }
            super.isHighlighted = isHighlighted
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
