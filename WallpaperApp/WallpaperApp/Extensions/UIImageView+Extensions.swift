//
//  UIImageView+Extensions.swift
//  WallpaperApp
//
//  Created by Şükrü on 25.08.2024.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - UIImageView Extensions
extension UIImageView {
    
    // MARK: - Load URL
    final func loadImageWithURL(with imageURL: String?) {
        guard let imageURL = imageURL else {
            return
        }
        
        kf.setImage(with: URL(string: imageURL))
    }
}
