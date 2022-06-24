//
//  Photo.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 22/05/22.
//

import Foundation
import RealmSwift

class Photoo: Object {

    // updated
    @Persisted var photo: String
    @Persisted var ownerID: String
    
//    init(photo: String, ownerID: String) {
//        self.photo = photo
//        self.ownerID = ownerID
//    }
//
//    required init() {
//        fatalError("init() has not been implemented")
//    }
}
