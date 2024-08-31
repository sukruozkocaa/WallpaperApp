//
//  WallpaperListResponse.swift
//  WallpaperApp
//
//  Created by Şükrü on 21.08.2024.
//

import Foundation

struct PexelsResponse: Codable {
    let page: Int?
    let perPage: Int?
    let photos: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
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

enum CategoryTypes: String, CaseIterable {
    case catalog
    case best
    case summer
    case animal
    case architecture
    case art
    case autumn
    case beach
    case canyon
    case car
    case city
    case darkTheme
    case flowers
    case love
    case nature
    case sky
    case water
    case snow
}

extension CategoryTypes {
    var viewTitle: String? {
        switch self {
        case .catalog:
            return "Catalog"
        case .best:
            return "Best"
        case .summer:
            return "Summer"
        case .animal:
            return "Animal"
        case .architecture:
            return "Architecture"
        case .art:
            return "Art"
        case .autumn:
            return "Autumn"
        case .beach:
            return "Beach"
        case .canyon:
            return "Canyon"
        case .car:
            return "Car"
        case .city:
            return "City"
        case .darkTheme:
            return "Dark Theme"
        case .flowers:
            return "Flower"
        case .love:
            return "Love"
        case .nature:
            return "Nature"
        case .sky:
            return "Sky"
        case .water:
            return "Water"
        case .snow:
            return "Snow"
        }
    }
}
