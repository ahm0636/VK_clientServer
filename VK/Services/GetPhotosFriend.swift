//
//  GetPhotosFriend.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 28/05/22.
//

import UIKit
import RealmSwift

struct PhotosResponse: Decodable {

    var response: Response
    struct Response: Decodable {
        var count: Int
        var items: [Item]

        struct Item: Decodable {
            var ownerID: Int
            var sizes: [Sizes]

            private enum CodingKeys: String, CodingKey {
                case ownerID = "owner_id"
                case sizes
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)

                ownerID = try container.decode(Int.self, forKey: .ownerID)
                sizes = try container.decode([Sizes].self, forKey: .sizes)
            }

            struct Sizes: Decodable {
                var url: String
            }
        }
    }
}


class GetPhotosFriend {

    // data to auth to vk
    func loadData(_ ownerID: String, complition: @escaping () -> Void ) {

        // default configurations
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        var urlConstructor = URLComponents()
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems = [
                URLQueryItem(name: "owner_id", value: ownerID),
                URLQueryItem(name: "access_token", value: Session.instance.token),
                URLQueryItem(name: "v", value: "5.122")
            ]

            // tast to run
            let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
                //print("Запрос к API: \(urlConstructor.url!)")
                do {
                    let arrayPhotosFriend = try JSONDecoder().decode(PhotosResponse.self, from: data!)
                    var photosFriend: [Photoo] = []
                    var ownerID = ""

                    for i in 0...arrayPhotosFriend.response.items.count-1 {
                        if let urlPhoto = arrayPhotosFriend.response.items[i].sizes.last?.url {
                            ownerID = String(arrayPhotosFriend.response.items[i].ownerID)
                            photosFriend.append(Photoo.init(photo: urlPhoto, ownerID: ownerID))
                        }
                    }
                    DispatchQueue.main.async {
                        RealmOperations().savePhotosToRealm(photosFriend, ownerID)
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
