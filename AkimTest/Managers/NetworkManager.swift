//
//  NetworkManager.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData(completion: @escaping ([MediaModel]?) -> Void) {
        
        let url = "https://wall.appthe.club"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let mediaData = try decoder.decode(MediaData.self, from: data)
                    completion(mediaData.media)
                } catch {
                    completion(nil)
                }
            case .failure:
                completion(nil)
            }
        }
    }
}

struct MediaData: Codable {
    let media: [MediaModel]
}

struct MediaModel: Codable {
    let image: URL
    let video: URL
}
