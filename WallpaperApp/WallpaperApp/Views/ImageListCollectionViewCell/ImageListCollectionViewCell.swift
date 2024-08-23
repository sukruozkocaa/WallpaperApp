//
//  ImageListCollectionViewCell.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import UIKit

// MARK: - ImageListCollectionViewCell
final class ImageListCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageCardView: ImageCardView = {
        let view = ImageCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        setupImageCardView()
    }
    
    final func setupImageCardView() {
        addSubview(imageCardView)
        
        NSLayoutConstraint.activate([
            imageCardView.widthAnchor.constraint(equalTo: widthAnchor),
            imageCardView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
