//
//  NetworkManager.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager(); private init() {}
    
    let url = "https://wall.appthe.club"
    
    func fetchData(completion: @escaping (Result<[WallpaperModel], Error>) -> Void) {
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let mediaData = try decoder.decode(WallpaperData.self, from: data)
                    completion(.success(mediaData.media))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct WallpaperData: Codable {
    let media: [WallpaperModel]
}
