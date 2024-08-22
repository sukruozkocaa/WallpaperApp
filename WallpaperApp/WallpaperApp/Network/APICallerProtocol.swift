//
//  APICallerProtocol.swift
//  WallpaperApp
//
//  Created by Şükrü on 21.08.2024.
//

import Foundation

protocol APICallerProtocol {
    func apiCaller(fetchData _completion: @escaping (Result<WallpaperListResponse, Error>) -> Void) 
}
