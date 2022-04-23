//
//  Session.swift
//  VK_A
//
//  Created by Aurelica Apps iOS Dev - 1 on 23/04/22.
//

import Foundation


class Session {
    private init() {}

    static let instance = Session()

    var token = "" // token storage
    var id = 0 // User ID storage

}
