//
//  APICallerProtocol.swift
//  WallpaperApp
//
//  Created by Şükrü on 21.08.2024.
//

import Foundation

protocol APICallerProtocol {
    func apiCallerForSearch(categoryType: CategoryTypes?, page: Int, completion: @escaping (Result<PexelsResponse, Error>) -> Void)
    func apiCallerCategoryList(categoryType: CategoryTypes, completion: @escaping (Result<PexelsResponse, Error>) -> Void)
}
