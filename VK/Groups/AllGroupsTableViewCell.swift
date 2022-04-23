//
//  AllGroupsTableViewCell.swift
//  VK_A
//
//  Created by Aurelica Apps iOS Dev - 1 on 10/04/22.
//

import UIKit

private let identifier = "Cell"
class AllGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var viewForImage2: UIView!
    @IBOutlet weak var allGroupsName: UILabel!
    @IBOutlet weak var allGroupsPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewForImage2.layer.masksToBounds = true
        self.viewForImage2.layer.cornerRadius = viewForImage2.frame.height / 2

        viewForImage2.backgroundColor = .clear
        viewForImage2.layer.shadowOffset = CGSize.zero
        viewForImage2.layer.shadowOpacity = 0.5
        viewForImage2.layer.borderColor = UIColor.black.cgColor
        self.allGroupsPhoto.clipsToBounds = true
        self.allGroupsPhoto.layer.masksToBounds = true
        self.allGroupsPhoto.layer.cornerRadius = allGroupsPhoto.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
