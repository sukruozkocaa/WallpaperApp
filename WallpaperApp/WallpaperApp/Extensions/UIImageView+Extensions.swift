//
//  UIImageView+Extensions.swift
//  WallpaperApp
//
//  Created by Şükrü on 25.08.2024.
//

import Foundation
import UIKit
import Kingfisher
import SDWebImage

// MARK: - UIImageView Extensions
extension UIImageView {
    
    // MARK: - Load URL
    final func loadImageWithURL(with imageURL: String?) {
        guard let imageURL = imageURL else {
            return
        }
        
        sd_setImage(with: URL(string: imageURL))
    }
    
    final func setLoadingIndicator() {
        sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
    }
}
