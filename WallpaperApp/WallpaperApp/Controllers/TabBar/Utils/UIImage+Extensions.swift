//
//  UIImage+Extensions.swift
//  WallpaperApp
//
//  Created by Şükrü on 2.09.2024.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(named: String) {
        self.init(named: named, in: .resourceBundle, compatibleWith: nil)
    }
}

private class LocalBundle {}
extension Bundle {
    static let resourceBundle: Bundle = {
        #if SWIFT_PACKAGE
        return .module
        #else
        return Bundle(for: LocalBundle.self)
        #endif
    }()
}
