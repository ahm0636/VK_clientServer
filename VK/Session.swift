//
//  Session.swift
//  VK_A
//
//  Created by Aurelica Apps iOS Dev - 1 on 23/04/22.
//

import Foundation


struct Session {

    private init() {}

    static var instance = Session()

    
    var token: String = ""
    var userID: Int = 0
}

/*
class Session {
    private init() {}

    static let instance = Session()

    var token = "" // token storage
    var userId = 0 // User ID storage

}*/
