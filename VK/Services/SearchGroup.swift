//
//  SearchGroup.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 17/06/22.
//

import Foundation

class SearchGroup {

    func loadData(searchText:String, complition: @escaping ([Groupp]) -> Void ) {


        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)

        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.search"
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.122")
        ]

        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            //    print("Request к API: \(urlConstructor.url!)")

            // в замыкании данные, полученные от сервера, мы преобразуем в json
            guard let data = data else { return }

            do {
                let arrayGroups = try JSONDecoder().decode(GroupsResponse.self, from: data)
                var searchGroup: [Groupp] = []

                for i in 0...arrayGroups.response.items.count-1 {
                    let name = ((arrayGroups.response.items[i].name))
                    let logo = arrayGroups.response.items[i].logo
                    let id = arrayGroups.response.items[i].id
//                    searchGroup.append(Groupp.init(groupName: name, groupLogo: logo, id: id))
                }

 //               complition(searchGroup)
            } catch let error {
                print(error)
                complition([])
            }
        }
        task.resume()

    }
}
