//
//  APICaller.swift
//  WallpaperApp
//
//  Created by Şükrü on 21.08.2024.
//

import Foundation
import Alamofire

enum APIError: Error {
    case failedToGetData
}

// MARK: - APICaller
struct APICaller: APICallerProtocol {
    
    // MARK: - Static Variables
    static let shared = APICaller()
    
    // MARK: - Initialize
    init() {}

    // MARK: - Fetch Data
    func apiCallerForSearch(categoryType: CategoryTypes?, page: Int, completion: @escaping (Result<PexelsResponse, Error>) -> Void) {
        let urlString = "\(APIConstants.baseAPIURL)search?query=\(categoryType?.rawValue ?? "")&per_page=20"
        
        guard let url = URL(string: urlString) else {
            return
        }
                
        let headers: HTTPHeaders = [
            "Authorization": APIConstants.API_KEY
        ]
          
        AF.request(url, method: .get, headers: headers).responseDecodable(of: PexelsResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func apiCallerCategoryList(categoryType cateyoryType: CategoryTypes, completion: @escaping (Result<PexelsResponse, Error>) -> Void) {
        let urlString = "\(APIConstants.baseAPIURL)search?query=\(cateyoryType.rawValue)&per_page=1"
        
        guard let url = URL(string: urlString) else {
            return
        }
                
        let headers: HTTPHeaders = [
            "Authorization": APIConstants.API_KEY
        ]
          
        AF.request(url, method: .get, headers: headers).responseDecodable(of: PexelsResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
