//
//  APICallerProtocol.swift
//  WallpaperApp
//
//  Created by Şükrü on 21.08.2024.
//

import Foundation

protocol APICallerProtocol {
    func apiCallerForSearch(searchText: String?, nextPageURL: String?, completion: @escaping (Result<PexelsResponse, Error>) -> Void)
    func apiCallerCategoryList(nextPageURL: String?, completion: @escaping (Result<CategoryListDataModel, Error>) -> Void)
    func apiCallerCategoryDetail(categoryId: String, count: String, completion: @escaping (Result<CategoryDetailDataModel, Error>) -> Void)
    func apiCallerCategoryItemsList(nextPageURL: String?, categoryId: String, completion: @escaping (Result<CategoryDetailDataModel, Error>) -> Void)
}
