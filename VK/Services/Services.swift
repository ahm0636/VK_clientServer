//
//  Services.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 06/05/22.
//

import Foundation
import RealmSwift

class DataFromVK {

    func loadData(_ parameters: parametersAPI) {

        let configuration = URLSessionConfiguration.default

        let session =  URLSession(configuration: configuration)

                // constructor for URL
                var urlConstructor = URLComponents()
                urlConstructor.scheme = "https"
                urlConstructor.host = "api.vk.com"
                urlConstructor.queryItems = [
                    URLQueryItem(name: "access_token", value: Session.instance.token),
                    URLQueryItem(name: "v", value: "5.120")
                ]

        switch parameters {
        case .usernamesAndAvatars:
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.instance.userID)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
        case .photos:
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems?.append(URLQueryItem(name: "owner_id", value: String(Session.instance.userID)))
        case .groups:
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.instance.userID)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .searchGroups:
            urlConstructor.path = "/method/groups.search"
            urlConstructor.queryItems?.append(URLQueryItem(name: "q", value: "video")) // нужно использовать поисковую фразу
            urlConstructor.queryItems?.append(URLQueryItem(name: "type", value: "group"))
        }


        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in

            let json = try? JSONSerialization.jsonObject(with: data!)
            print("print json: \(String(describing: json))")

        }
        task.resume()

    }

    enum parametersAPI {
        case photos
        case groups
        case searchGroups
        case usernamesAndAvatars
    }

}
