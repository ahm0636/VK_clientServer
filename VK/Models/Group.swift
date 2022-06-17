//
//  Group.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 28/05/22.
//

import Foundation
import RealmSwift

class Groupp: Object {
    @Persisted var groupName: String = ""
    @Persisted var groupPhoto: String = ""
}
