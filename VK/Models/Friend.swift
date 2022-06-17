//
//  Friend.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 28/05/22.
//

import Foundation

import RealmSwift

class Friend: Object {
    @Persisted var friendName: String
    @Persisted var friendAvatar: String
    @Persisted var ownerID: String

}
