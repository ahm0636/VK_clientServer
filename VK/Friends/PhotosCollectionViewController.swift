//
//  MyCollectionCollectionViewController.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 24/03/22.
//

import UIKit
import RealmSwift
import Kingfisher

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    // MARK: - ATTRIBUTES
    var collectionPhotos: [Photoo] = []
    var ownerID: String = ""

    var allFriends = User.allMates

    var friendIndex: Int = 0

    var notificationToken: NotificationToken?

    var realm: Realm = {
        let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: configrealm)
        return realm
    }()

    lazy var photosFromRealm: Results<Photoo> = {
        return realm.objects(Photoo.self).filter("ownerID == %@", ownerID)
    }()

    var friend: User!

    // MARK: - CUSTON FUNCTIONS
    
    func loadPhotosFromRealm() {
        do {
            let realm = try Realm()
            let tester = Photoo()
            let photosFromRealm = realm.objects(Photoo.self).filter("ownerID == %@", tester.ownerID)
            collectionPhotos = Array(photosFromRealm)
            // check Realm
            guard collectionPhotos.count != 0 else { return }
            collectionView.reloadData()
        } catch {
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        GetPhotosFriend().loadData(ownerID) { [weak self] () in
            self?.loadPhotosFromRealm()
        }

    }

    @IBAction func test(_ sender: Any) {
        print("tapped")
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return allFriends[friendIndex].photos.count
        return collectionPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MatesDetailedCollectionViewCell
//        let photo = allFriends[friendIndex].photos[indexPath.row]
//        let photo = collectionPhotos[indexPath.row]
//        cell?.imageView.image = UIImage(named: photo)
//        cell?.imageView.image =  UIImage(named: photo.photo)
//        cell?.likeControl.isSelected = photo.isLiked
        cell.photoDidLiked = { isSelected in
            self.allFriends[self.friendIndex].photos[indexPath.row].isLiked = isSelected
        }

        if let imgUrl = URL(string: collectionPhotos[indexPath.row].photo) {
                   let photo = ImageResource(downloadURL: imgUrl)
            cell.imageView.kf.setImage(with: photo)
               }

        return cell
    }

    // MARK: - NAVIGATION
    // go to controller that shows large photos
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // controllers' identifier
        if segue.identifier == "showUserPhoto"{
            guard let photosFriend = segue.destination as? FriendsPhotosViewController else { return }

            // the index of selected cell
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                photosFriend.allPhotos = collectionPhotos
                photosFriend.countCurentPhoto = indexPath.row // indexPath[0][1]
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }


}

extension PhotosCollectionViewController {
    private func subscribeToRealmNotification() {
        notificationToken = photosFromRealm.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.loadPhotosFromRealm()
            case .update:
                self?.loadPhotosFromRealm()
            case let .error(error):
                print(error)
            }
        }
    }
}
