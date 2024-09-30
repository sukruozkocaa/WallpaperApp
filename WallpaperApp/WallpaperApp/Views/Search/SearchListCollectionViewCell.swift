//
//  SearchListCollectionViewCell.swift
//  WallpaperApp
//
//  Created by Şükrü on 6.09.2024.
//

import UIKit

// MARK: - ImageListCollectionViewCell
final class SearchListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    lazy var imageCardView: ImageCardView = {
        let view = ImageCardView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views
private extension SearchListCollectionViewCell {
    final func setupViews() {
        setupImageCardView()
    }
    
    final func setupImageCardView() {
        addSubview(imageCardView)
        
        NSLayoutConstraint.activate([
            imageCardView.topAnchor.constraint(equalTo: topAnchor, constant: 1.0),
            imageCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1.0),
            imageCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0),
            imageCardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0)
        ])
    }
}

// MARK: - Configure
extension SearchListCollectionViewCell {
    final func configure(item: Photo) {
        imageCardView.borderColor = UIColor(hexString: item.avgColor ?? "").cgColor
        imageCardView.setImage(with: item.src?.original)
        imageCardView.configureBottomBannerView(iconImage: UIImage(named: "ic_user_fill"), titleText: item.photographer)
    }
}
