//
//  CategoryListDataModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 29.08.2024.
//

import Foundation

class CategoryListDataModel: Decodable {
    let page: Int?
    let per_page: Int?
    var collections: [CategoryListCollection]?
    let total_results: Int?
    let next_page: String?
    let prev_page: String?
}

class CategoryListCollection: Decodable {
    let id: String?
    let title: String?
    let description: String?
    let is_private: Bool?
    let media_count: Int?
    let photos_count: Int?
    let videos_count: Int?
    var photoList: [CategoryMediaDataModel]?
}
