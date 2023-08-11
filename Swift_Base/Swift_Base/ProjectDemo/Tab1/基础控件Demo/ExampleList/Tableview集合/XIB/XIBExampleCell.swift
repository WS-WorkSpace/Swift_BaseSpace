//
//  XIBExampleCell.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/11.
//

import UIKit

class XIBExampleCell: UITableViewCell {
    static let CellID = "XIBExampleCell_ID"
    
    @IBOutlet weak var leftLab: UILabel!
    @IBOutlet weak var rightImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
