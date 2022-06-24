//
//  UserFirebase.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 24/06/22.
//

import Foundation
import FirebaseDatabase

class UserFirebase {

    let userID: Int

    var reference: DatabaseReference?

    init(userID: Int) {
        self.userID = userID
    }

    // optional init
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let userID = value["userID"] as? Int
        else { return nil }

        self.userID = userID

        self.reference = snapshot.ref
    }

    func convertToDictionary() -> [String: Any] {
        return [
            "userID": userID,
        ]
    }
}
