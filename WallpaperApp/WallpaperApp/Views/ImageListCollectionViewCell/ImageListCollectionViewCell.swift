//
//  ImageListCollectionViewCell.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import UIKit

// MARK: - ImageListCollectionViewCell
final class ImageListCollectionViewCell: UICollectionViewCell {
    
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
private extension ImageListCollectionViewCell {
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
//            imageCardView.widthAnchor.constraint(equalTo: widthAnchor),
//            imageCardView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}

// MARK: - Configure
extension ImageListCollectionViewCell {
    final func configure(item: CategoryMediaDataModel) {
        imageCardView.borderColor = UIColor(hexString: item.avg_color ?? "").cgColor
        imageCardView.setImage(with: item.src?.original)
        imageCardView.configureBottomBannerView(iconImage: UIImage(named: "icPencilVector"), titleText: item.photographer)
    }
}
