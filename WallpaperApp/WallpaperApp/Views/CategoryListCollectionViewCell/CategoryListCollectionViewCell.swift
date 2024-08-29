//
//  CategoryListCollectionViewCell.swift
//  WallpaperApp
//
//  Created by Şükrü on 28.08.2024.
//

import UIKit

// MARK: - CategoryListCollectionViewCell
final class CategoryListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Override Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup Views
private extension CategoryListCollectionViewCell {
    final func setupViews() {
        setupImageView()
        setupGradientView()
        setupTitleLabel()
    }
    
    final func setupImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    final func setupGradientView() {
        imageView.addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            gradientView.heightAnchor.constraint(equalToConstant: 50.0),
            gradientView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            gradientView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    final func setupTitleLabel() {
        gradientView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: gradientView.centerYAnchor)
        ])
    }
}

// MARK: - Configure
extension CategoryListCollectionViewCell {
    final func configure(title: String, image: Photo) {
        titleLabel.text = title
        imageView.loadImageWithURL(with: image.src?.original)
    }
}
