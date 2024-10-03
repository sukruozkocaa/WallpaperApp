//
//  CategoryDetailCollectionViewCell.swift
//  WallpaperApp
//
//  Created by Şükrü on 30.08.2024.
//

import UIKit

// MARK: - CategoryDetailCollectionViewCell
final class CategoryDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setLoadingIndicator()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
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
private extension CategoryDetailCollectionViewCell {
    final func setupImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}

// MARK: - Configure
extension CategoryDetailCollectionViewCell {
    final func configure(item: CategoryMediaDataModel?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.layer.borderWidth = 2.0
            self.imageView.layer.borderColor = UIColor(hexString: item?.avg_color ?? "").cgColor
            self.imageView.loadImageWithURL(with: item?.src?.original)
        }
    }
}

// MARK: - Helpers
extension CategoryDetailCollectionViewCell {
    final func getImage() -> UIImage? {
        return imageView.image
    }
}
