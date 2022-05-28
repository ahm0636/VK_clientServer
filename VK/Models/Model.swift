//
//  Model.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 26/03/22.
//

import Foundation
import UIKit


enum ProfileType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"

}

    // MARK: - Group Model
struct Group {
    let id: String
    let avatar: String
    let groupDescription: String
    let numberOfMembers: Int
    let name: String
    let isPrivate: Bool
    let photo: [Photo]

}

extension Group {
    static var allGroups: [Group] = [
        Group(id: "1", avatar: "meme", groupDescription: "first group", numberOfMembers: 23, name: "RGB Group", isPrivate: true, photo: [Photo(photo: "meme", name: "it is a photo", isLiked: false)]),
        Group(id: "2", avatar: "avatar", groupDescription: "second group", numberOfMembers: 23, name: "Style Group", isPrivate: true, photo: [Photo(photo: "3 photo", name: "it is a photo", isLiked: false)]),
        Group(id: "3", avatar: "meme", groupDescription: "third group", numberOfMembers: 23, name: "Rock Group", isPrivate: true, photo: [Photo(photo: "2 photo", name: "it is a photo", isLiked: false)]),
        Group(id: "4", avatar: "meme", groupDescription: "fourth group", numberOfMembers: 23, name: "ST Group", isPrivate: true, photo: [Photo(photo: "1 photo", name: "it is a photo", isLiked: false)])
    ]
}
    // MARK: - Photo model
struct Photo {
    var photo: String
    let name: String
    var isLiked: Bool
}

    // MARK: - User model
struct User {
    let name: String
    let profileType: ProfileType.RawValue
    let id: String
    var photos: [Photo]
    let avatar: String
    let groups: [Group]
    var age: Int
    let surname: String
    let aboutMe: String
}

struct News {
    let photo: String
    let image: [Photo]
    let name: String
}

extension News {
    static let allNews: [News] = [
        News(photo: "news", image: [Photo(photo: "photo", name: "USA", isLiked: false)], name: "today's news"),
        News(photo: "male_photo", image: [Photo(photo: "photo2", name: "Turkey", isLiked: false)], name: "sw")
]
}

extension User {
    static let allMates: [User] = [
        User(name: "Susan", profileType: "Advanced", id: "", photos: [Photo(photo: "man_photo",
                                                                   name: "ph", isLiked: false), Photo(photo: "heart", name: "2 photo", isLiked: false)], avatar: "meme", groups: [Group(id: "1", avatar: "meme", groupDescription: "Susan's group", numberOfMembers: 23, name: "BBC", isPrivate: true, photo: [Photo(photo: "sherry-christian-8Myh76_3M2U-unsplash.jpg", name: "ph", isLiked: false)])], age: 34, surname: "Su", aboutMe: "News"),
        User(name: "Rock", profileType: "Advanced", id: "", photos: [Photo(photo: "heart", name: "ph", isLiked: false)], avatar: "male_photo", groups: [Group(id: "2", avatar: "heart", groupDescription: "Rock's group", numberOfMembers: 23, name: "2", isPrivate: true, photo: [Photo(photo: "BBC photo", name: "ph", isLiked: false)])], age: 34, surname: "Su", aboutMe: "News"),
        User(name: "Swift", profileType: "Advanced", id: "", photos: [Photo(photo: "first photo", name: "ph", isLiked: false)], avatar: "man_photo", groups: [Group(id: "3", avatar: "meme", groupDescription: "Swift's group", numberOfMembers: 23, name: "4", isPrivate: true, photo: [Photo(photo: "second photo", name: "ph", isLiked: false)])], age: 34, surname: "Su", aboutMe: "News"),
        User(name: "Doks", profileType: "Advanced", id: "", photos: [Photo(photo: "fourth photo", name: "ph", isLiked: false)], avatar: "man_photo", groups: [Group(id: "4", avatar: "heart", groupDescription: "Doks group", numberOfMembers: 23, name: "B5", isPrivate: true, photo: [Photo(photo: "BBC photo", name: "ph", isLiked: false)])], age: 34, surname: "Su", aboutMe: "News"),
        User(name: "Karl", profileType: "Advanced", id: "", photos: [Photo(photo: "fourth photo", name: "ph", isLiked: false)], avatar: "heart", groups: [Group(id: "5", avatar: "", groupDescription: "Karl's group", numberOfMembers: 23, name: "B5", isPrivate: true, photo: [Photo(photo: "BBC photo", name: "ph", isLiked: false)])], age: 34, surname: "Su", aboutMe: "News"),
        User(name: "Rocky", profileType: "Advanced", id: "", photos: [Photo(photo: "fourth photo", name: "ph", isLiked: false)], avatar: "VKimage", groups: [Group(id: "6", avatar: "meme", groupDescription: "Rocky's group", numberOfMembers: 23, name: "B5", isPrivate: true, photo: [Photo(photo: "BBC photo", name: "ph", isLiked: false)])], age: 34, surname: "Su", aboutMe: "News"),
        User(name: "KOSTAS", profileType: "Advanced", id: "", photos: [Photo(photo: "fourth photo", name: "ph", isLiked: false)], avatar: "male_photo", groups: [Group(id: "7", avatar: "meme", groupDescription: "Kos group", numberOfMembers: 23, name: "B5", isPrivate: true, photo: [Photo(photo: "BBC photo", name: "ph", isLiked: false)])], age: 34, surname: "Su", aboutMe: "News")
    ]
}




