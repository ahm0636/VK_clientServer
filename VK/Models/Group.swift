//
//  Group.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 28/05/22.
//

import Foundation
import RealmSwift


class Groupp: Object {
    @objc dynamic var groupName: String = ""
    @objc dynamic var groupPhoto: String = ""

    init(groupName: String, groupPhoto: String) {
        self.groupName = groupName
        self.groupPhoto = groupPhoto
    }

    required init() {
        fatalError("init() has not been implemented")
    }

}
