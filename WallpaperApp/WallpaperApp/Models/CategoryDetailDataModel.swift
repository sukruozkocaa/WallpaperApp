//
//  CategoryDetailDataModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 29.08.2024.
//

import Foundation

class CategoryDetailDataModel: Codable {
    let page: Int?
    let per_page: Int?
    var media: [CategoryMediaDataModel]?
    let total_results: Int?
    let next_page: String?
    let id: String?
}

struct CategoryMediaDataModel: Codable {
    let type: String?
    let id: Int?
    let width: Int?
    let height: Int?
    let url: String?
    let photographer: String?
    let photographer_url: String?
    let photographer_id: Int?
    let avg_color: String?
    let src: PhotoSrc?
    let liked: Bool?
    let alt: String?
}
