//
//  NetworkManager.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData(completion: @escaping ([MediaModel]?) -> Void) {

        guard let url = URL(string: "https://wall.appthe.club") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mediaData = try decoder.decode(MediaData.self, from: data)
                completion(mediaData.media)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

struct MediaData: Codable {
    let media: [MediaModel]
}

struct MediaModel: Codable {
    let image: URL
    let video: URL
}

