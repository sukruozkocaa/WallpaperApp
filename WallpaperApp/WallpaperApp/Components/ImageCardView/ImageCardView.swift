//
//  ImageCardView.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - ImageCardView
final class ImageCardView: UIView {
    
    // MARK: - Views
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 8.0
        imageView.layer.borderWidth = 0.5
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.setLoadingIndicator()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bottomBannerView: ImageBottomBannerView = {
        let view = ImageBottomBannerView()
        view.layer.masksToBounds = true
        view.backgroundColor = Theme.Color.black.withAlphaComponent(bannerBackgroundColorRatio)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    // MARK: - Variables
    var bannerBackgroundColorRatio: CGFloat = 0.6
    var cornerRadius: CGFloat = .zero {
        didSet {
            imageView.layer.cornerRadius = cornerRadius
        }
    }
    
    var borderColor: CGColor = Theme.borderColor.gray {
        didSet {
            imageView.layer.borderColor = borderColor
        }
    }
    
    var borderWidth: CGFloat = 1.0 {
        didSet {
            imageView.layer.borderWidth = borderWidth
        }
    }
        
    // MARK: - Override Init.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views
private extension ImageCardView {
    final func setupViews() {
        setupImageView()
        setupBottomBannerView()
    }
    
    final func setupImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    final func setupBottomBannerView() {
        imageView.addSubview(bottomBannerView)
        
        NSLayoutConstraint.activate([
            bottomBannerView.heightAnchor.constraint(equalToConstant: 30.0),
            bottomBannerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            bottomBannerView.widthAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
}

// MARK: - Helpers
extension ImageCardView {
    final func setImage(with url: String?) {
        imageView.loadImageWithURL(with: url)
    }
    
    final func configureBottomBannerView(iconImage: UIImage?, titleText: String?) {
        bottomBannerView.configure(iconImage: iconImage, titleText: titleText)
    }
}
