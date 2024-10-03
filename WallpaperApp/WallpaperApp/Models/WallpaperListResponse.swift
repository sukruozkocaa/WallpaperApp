//
//  WallpaperListResponse.swift
//  WallpaperApp
//
//  Created by Şükrü on 21.08.2024.
//

import Foundation

class PexelsResponse: Codable {
    let page: Int?
    let perPage: Int?
    var photos: [Photo]?
    let totalResults: Int?
    let nextPage: String?
        
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
        case totalResults = "total_results"
        case nextPage = "next_page"
    }
}

struct Photo: Codable {
    let id: Int?
    let width: Int?
    let height: Int?
    let url: String?
    let photographer: String?
    let photographer_url: String?
    let photographer_id: Int?
    let avgColor: String?
    let src: PhotoSrc?
    let liked: Bool?
    let alt: String?
}

struct PhotoSrc: Codable {
    let original: String?
    let large2x: String?
    let large: String?
    let medium: String?
    let small: String?
    let portrait: String?
    let landspace: String?
    let tiny: String?
}
