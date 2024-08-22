//
//  APICaller.swift
//  WallpaperApp
//
//  Created by Şükrü on 21.08.2024.
//

import Foundation

// MARK: - APICaller
struct APICaller: APICallerProtocol {
    
    // MARK: - Static Variables
    static let shared = APICaller()
    
    // MARK: - Initialize
    init() {}

    // MARK: - Fetch Data
    func apiCaller(fetchData _completion: @escaping (Result<WallpaperListResponse, Error>) -> Void) {
        let urlString = "\(APIConstants.baseAPIURL)/list/all"
        // REQUEST
    }
}
