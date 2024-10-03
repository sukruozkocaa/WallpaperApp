//
//  ImageBottomBannerView.swift
//  WallpaperApp
//
//  Created by Şükrü on 26.08.2024.
//

import Foundation
import UIKit

// MARK: - ImageBottomBannerView
final class ImageBottomBannerView: UIView {
    
    // MARK: - Views
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Theme.Color.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.AppFont.bannerTitle
        label.textColor = Theme.Color.white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Constants
    private let iconWidth: CGFloat = 20.0
    private let iconHeight: CGFloat = 20.0
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views
private extension ImageBottomBannerView {
    final func setupViews() {
        setupIconImageView()
        setupTitleLabel()
    }
    
    final func setupIconImageView() {
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: iconWidth),
            iconImageView.heightAnchor.constraint(equalToConstant: iconHeight),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0)
        ])
    }
    
    final func setupTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.0),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8.0),
        ])
    }
}

// MARK: - Configure
extension ImageBottomBannerView {
    final func configure(iconImage: UIImage?, titleText: String?) {
        iconImageView.image = iconImage?.withRenderingMode(.alwaysOriginal)
        titleLabel.text = titleText
    }
}
