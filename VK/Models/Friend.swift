//
//  Friend.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 28/05/22.
//

import Foundation

import RealmSwift


class Friend: Object {
    @objc dynamic var friendName: String = ""
    @objc dynamic var friendAvatar: String = ""

    init(friendName: String, friendAvatar: String) {
        self.friendName = friendName
        self.friendAvatar = friendAvatar
    }

    required init() {
        fatalError("init() has not been implemented")
    }

}
