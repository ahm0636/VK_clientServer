//
//  SecondCellTableViewCell.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 29/03/22.
//

import UIKit

class SecondCellTableViewCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.groupPhoto.clipsToBounds = true
        self.groupPhoto.layer.masksToBounds = true
        self.groupPhoto.layer.cornerRadius = groupPhoto.frame.height / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
