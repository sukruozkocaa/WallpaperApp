//
//  String+Extensions.swift
//  WallpaperApp
//
//  Created by Şükrü on 30.08.2024.
//

import Foundation

extension String {
    var localized: String {
      return NSLocalizedString(self, comment: "\(self)_comment")
    }
}
