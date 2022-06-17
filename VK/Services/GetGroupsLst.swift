//
//  GetGroupsLst.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 22/05/22.
//

import Foundation
import RealmSwift

struct GroupsResponse:  Decodable {
    var response: Response

    struct Response: Decodable {
        var count: Int
        var items: [Item]

        struct Item: Decodable {
            var name: String
            var logo: String
            var id: Int

            enum CodingKeys: String, CodingKey {
                case name
                case logo = "photo_50"
                case id
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                name = try container.decode(String.self, forKey: .name)
                logo = try container.decode(String.self, forKey: .logo)
                id = try container.decode(Int.self, forKey: .id)
            }
        }
    }
}

class GetGroupsList {

    // данные для авторизации в ВК
    func loadData(complition: @escaping () -> Void ) {

        // defualt configuration
        let configuration = URLSessionConfiguration.default

        let session =  URLSession(configuration: configuration)

        // constructor for URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.instance.userID)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.122")
        ]

        // task to run
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            //print("Request to API: \(urlConstructor.url!)")

            /* in the closure, we will convert
            the data received from the server to json*/
            guard let data = data else { return }

            do {
                let arrayGroups = try JSONDecoder().decode(GroupsResponse.self, from: data)
                var groupList: [Groupp] = []
                for i in 0...arrayGroups.response.items.count-1 {
                    let name = ((arrayGroups.response.items[i].name))
                    let logo = arrayGroups.response.items[i].logo

                    let test = Groupp()
                    test.groupName = name
                    test.groupPhoto = logo

                    groupList.append(test)
                }

                DispatchQueue.main.async {
                    RealmOperations().saveGroupsToRealm(groupList)
                    complition()
                }

            } catch let error {
                print(error)
                complition()
            }
        }
        task.resume()

    }
}

