//
//  ImageListCollectionViewCell.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import UIKit

// MARK: - ImageListCollectionViewCell
final class ImageListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.Color.black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views
private extension ImageListCollectionViewCell {
    final func setupViews() {
        
    }
}
