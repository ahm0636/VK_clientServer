//
//  MatesDetailedCollectionViewCell.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 29/03/22.
//

import UIKit
private let reuseIdentifier = "Cell"
class MatesDetailedCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var likeControl: LikeControl!

    @IBOutlet weak var imageView: UIImageView!
    var photoDidLiked: ((Bool) -> Void)?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        likeControl.addTarget(self, action: #selector(likeControlTapped), for: .touchUpInside)

    }


    @objc func likeControlTapped() {
        likeControl.isSelected = !likeControl.isSelected
        photoDidLiked?(likeControl.isSelected)
    }
}
