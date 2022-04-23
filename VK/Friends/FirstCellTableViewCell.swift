//
//  FirstCellTableViewCell.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 26/03/22.
//

import UIKit


class FirstCellTableViewCell: UITableViewCell {

//    let image: User
//    init(image: User) {
//        self.image = image
//        super.init(style: .default, reuseIdentifier: "cell")
//
//    }

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var viewForImage: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImage.contentMode = .scaleAspectFill
        self.viewForImage.layer.masksToBounds = true
        self.viewForImage.layer.cornerRadius = viewForImage.frame.height / 2

        viewForImage.backgroundColor = .clear
        viewForImage.layer.shadowOffset = CGSize.zero
        viewForImage.layer.shadowOpacity = 0.5
        viewForImage.layer.borderColor = UIColor.black.cgColor
        self.userImage.clipsToBounds = true
        self.userImage.layer.masksToBounds = true
        self.userImage.layer.cornerRadius = userImage.frame.height / 2

    }


//
//        likeButton.addTarget(
//            self, action: #selector(handleHeartButtonTap(_:)), for: .touchUpInside)
//        likeButton.imageView?.contentMode = .scaleAspectFill
//        likeButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
////        self.userImage.image = image.image
//    }
//
//    @objc private func handleHeartButtonTap(_ sender: UIButton) {
//      guard let button = sender as? HeartButton else { return }
//      button.flipLikedState()
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
