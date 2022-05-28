//
//  RealmOperations.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 22/05/22.
//

import Foundation
import RealmSwift

class RealmOperations {


    // MARK: - CUSTOM FUNCTIONS
    // saving photos
    func savePhotosToRealm(_ photoList: [Photoo], _ ownerID: String) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldPhotoList = realm.objects(Photoo.self).filter("ownerID == %@", ownerID)
                realm.delete(oldPhotoList)
                realm.add(photoList)
            }
        } catch {
            print(error)
        }
    }

    // saving groups
    func saveGroupsToRealm(_ groupList: [Groupp]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldGroupList = realm.objects(Groupp.self)
                realm.delete(oldGroupList)
                realm.add(groupList)
            }
        } catch {
            print(error)
        }
    }


    // saving friends
    func saveFriendsToRealm(_ friendList: [Friend]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldFriendList = realm.objects(Friend.self) // the list of existing friends
                realm.delete(oldFriendList) // requires to delete old data
                realm.add(friendList) // adding the new ones
            }
        } catch {
            print(error)
        }
    }

}
