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
    func apiCallerForSearch(searchText: String?, nextPageURL: String?, completion: @escaping (Result<PexelsResponse, Error>) -> Void) {
        var urlStr: String = ""
        
        if nextPageURL == nil {
            urlStr = "\(APIConstants.baseAPIURL)search?query=\(searchText ?? "")&page=1"
        } else {
            urlStr = nextPageURL ?? ""
        }
                
        guard let url = URL(string: urlStr) else { return }
        
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
    
    func apiCallerCategoryList(nextPageURL: String?, completion: @escaping (Result<CategoryListDataModel, Error>) -> Void) {
        var urlString: String = ""
                
        if nextPageURL == nil {
            urlString = "\(APIConstants.baseAPIURL)collections/featured?per_page=8"
        } else {
            urlString = nextPageURL ?? ""
        }
                
        guard let url = URL(string: urlString) else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": APIConstants.API_KEY
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CategoryListDataModel.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func apiCallerCategoryList(completion: @escaping (Result<CategoryListDataModel, Error>) -> Void) {
        let urlString = "\(APIConstants.baseAPIURL)collections/featured/?page=1&per_page=10"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": APIConstants.API_KEY
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CategoryListDataModel.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func apiCallerCategoryDetail(categoryId: String, count: String, completion: @escaping (Result<CategoryDetailDataModel, Error>) -> Void) {
        let urlString = "\(APIConstants.baseAPIURL)collections/\(categoryId)?per_page=10"

        print("URL \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }
 
        let headers: HTTPHeaders = [
            "Authorization": APIConstants.API_KEY
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CategoryDetailDataModel.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func apiCallerCategoryItemsList(nextPageURL: String?, categoryId: String, completion: @escaping (Result<CategoryDetailDataModel, Error>) -> Void) {
        var urlString: String = ""
        
        if nextPageURL == nil {
            urlString = "\(APIConstants.baseAPIURL)collections/\(categoryId)?per_page=8"
        } else {
            urlString = nextPageURL ?? ""
        }
                
        guard let url = URL(string: urlString) else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": APIConstants.API_KEY
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CategoryDetailDataModel.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
