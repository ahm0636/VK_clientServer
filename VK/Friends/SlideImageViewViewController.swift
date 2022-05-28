//
//  SlideImageViewViewController.swift
//  VK_A
//
//  Created by Aurelica Apps iOS Dev - 1 on 26/04/22.
//

import UIKit

class SlideImageViewViewController: UIViewController {

    var photos: [Photo] = []

    var currentPhotoIndex: Int?

    var nextPhotoIndex: Int? {
        guard let index = currentPhotoIndex else {
            return nil
        }

        let nextIndex = index + 1
        return nextIndex < photos.count ? nextIndex : nil
    }

    var previousPhotoIndex: Int? {
        guard let index = currentPhotoIndex else {
            return nil
        }

        let prevIndex = index - 1
        return prevIndex > -1 ? prevIndex : nil
    }

    var currentPhoto: Photo? {
        guard let index = currentPhotoIndex else {
            return nil
        }

        return photos[index]
    }

    @IBOutlet weak var fImageView: UIImageView!
    @IBOutlet weak var sImageView: UIImageView!

    var currentImageView: UIImageView? {
        [fImageView, sImageView].first(where: { !$0.isHidden })
    }

    var hiddenImageView: UIImageView? {
        [fImageView, sImageView].first(where: { $0.isHidden })
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        currentPhotoIndex = photos.isEmpty ? nil : 0

        fImageView.frame = view.bounds
        fImageView.image = UIImage(named: currentPhoto?.name ?? "")

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
