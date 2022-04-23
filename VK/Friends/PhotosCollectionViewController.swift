//
//  MyCollectionCollectionViewController.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 24/03/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    var matesPhotosArray: [Photo?] = []

    var allFriends = User.allMates

    var friendIndex: Int = 0


    var friend: User!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func test(_ sender: Any) {
        print("tapped")
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFriends[friendIndex].photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MatesDetailedCollectionViewCell
        let photo = allFriends[friendIndex].photos[indexPath.row]
        cell?.imageView.image =  UIImage(named: photo.photo)
        cell?.likeControl.isSelected = photo.isLiked
        cell?.photoDidLiked = { isSelected in
            self.allFriends[self.friendIndex].photos[indexPath.row].isLiked = isSelected
        }

        return cell ?? UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
//        CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2 )
    }

}
