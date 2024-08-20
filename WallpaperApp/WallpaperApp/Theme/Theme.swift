//
//  Theme.swift
//  WallpaperApp
//
//  Created by Şükrü on 21.08.2024.
//

import Foundation
import UIKit

// MARK: - Theme
final class Theme {
    enum cornerRadius {
        static let normal: CGFloat = 12.0
    }
}

// MARK: - Colors
extension Theme {
    enum Color {
        static let black: UIColor = .black
        static let white: UIColor = .white
        static let backgroundColor: UIColor = .systemBackground
    }
    
    enum borderColor {
        static let gray: CGColor = UIColor.gray.cgColor
    }
}

// MARK: - Fonts
extension Theme {
    enum AppFont {
        static let title = Font.systemFont(size: FontSize.normal, weight: FontWeight.semibold)
        static let subTitle = Font.systemFont(size: FontSize.small, weight: FontWeight.regular)
    }
    
    private enum Font {
        static func systemFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
            return .systemFont(ofSize: size, weight: weight)
        }
    }
    
    private enum FontWeight {
        static let bold = UIFont.Weight.bold
        static let regular = UIFont.Weight.regular
        static let light = UIFont.Weight.light
        static let semibold = UIFont.Weight.semibold
    }
    
    private enum FontSize {
        static let large: CGFloat = 19.0
        static let normal: CGFloat = 16.0
        static let small: CGFloat = 13.0
        static let extraSmall: CGFloat = 10.0
    }
}
