//
//  NewsTableViewCell.swift
//  VK_A
//
//  Created by Aurelica Apps iOS Dev - 1 on 12/04/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var likeControl: LikeControl!

    @IBOutlet weak var newsImageView: UIImageView!

    var photoDidLiked: ((Bool) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        likeControl.addTarget(self, action: #selector(likeControlTapped), for: .touchUpInside)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func likeControlTapped() {
        likeControl.isSelected = !likeControl.isSelected
        photoDidLiked?(likeControl.isSelected)
    }

}
