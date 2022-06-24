//
//  VKService.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 10/06/22.
//

import Foundation


enum Method {
    case friends
    case photos (ownerID: String)
    case groups
    case searchGroup (searchText: String)

    var path: String {
        switch self {
        case .friends:
            return "/method/friends.get"
        case .groups:
            return "/method/photos.getAll"
        case .photos:
            return "/method/groups.get"
        case .searchGroup:
            return "/method/groups.search"
        }
    }

    var parameters: [String: String] {
        switch self {
        case .friends:
            return [
                //"user_id" : String(Session.instance.userId),
                "fields": "photo_50",
                //"access_token" : Session.instance.token
            ]
        case .groups:
            return [
                //"user_id" : String(Session.instance.userId),
                "extended": "",
                //"access_token" : Session.instance.token
            ]
        case let .photos(ownerID):
            return [
                "owner_id": ownerID,
                //"access_token" : Session.instance.token
            ]
        case let .searchGroup(searchText):
            return [
                "q": searchText,
                "type": "group",
                //"access_token" : Session.instance.token
            ]
        }
    }
}

final class VKService {

    func loadData(_ method: Method, complition: @escaping () -> Void ) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = method.path

        let basicQueryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.122")
        ]
        let additionalQueryItems = method.parameters.map{ URLQueryItem(name: $0, value: $1) }
        // converting the dictionary
        urlConstructor.queryItems = basicQueryItems + additionalQueryItems

        guard let url = urlConstructor.url else {
            complition()
            return
        }

        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)

        let task = session.dataTask(with: url) { (data, response, error) in
            //print("Request to API: \(url)")

            if let error = error {
                print(error.localizedDescription)
                return
            }
            print(data ?? "")
            complition()
        }
        task.resume()
    }
}


