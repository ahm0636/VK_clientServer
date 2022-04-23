//
//  LikeControl.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 05/04/22.
//

import UIKit


class LikeControl: UIControl {


    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var counterLabel: UILabel?

    var likesCounter: Int = 0

    var isLiked: Bool = false

    private let unlikedImage = UIImage(named: "heart")
    private let likedImage = UIImage(named: "redHeart")

    override var isSelected: Bool {
        didSet {
            guard oldValue != isSelected else { return}
            animate()
            imageView?.image = isSelected ? UIImage(named: "redHeart") : UIImage(named: "heart")
//            animate()
            if isSelected {
                likesCounter += 1
            } else {
                likesCounter -= 1
            }

            counterLabel?.text = "\(likesCounter)"
        }
    }
    private func animate() {
      UIView.animate(withDuration: 0.1, animations: {
          let newImage = self.isLiked ? self.likedImage : self.unlikedImage! as UIImage
        self.transform = self.transform.scaledBy(x: 0.8, y: 0.8)
          self.imageView?.image = newImage
//        self.setImage(newImage, for: .normal)
      }, completion: { _ in
        // Step 2
        UIView.animate(withDuration: 0.1, animations: {
          self.transform = CGAffineTransform.identity
        })
      })
    }


}
