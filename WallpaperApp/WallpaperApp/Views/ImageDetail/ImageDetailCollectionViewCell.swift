//
//  ImageDetailCollectionViewCell.swift
//  WallpaperApp
//
//  Created by Şükrü on 31.08.2024.
//

import UIKit

// MARK: - ImageDetailCollectionViewCell
final class ImageDetailCollectionViewCell: UICollectionViewCell {
 
    // MARK: - Views
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup Views
private extension ImageDetailCollectionViewCell {
    final func setupImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}

// MARK: - Configure
extension ImageDetailCollectionViewCell {
    final func configure(imageURL: String?) {
        imageView.loadImageWithURL(with: imageURL)
    }
}
