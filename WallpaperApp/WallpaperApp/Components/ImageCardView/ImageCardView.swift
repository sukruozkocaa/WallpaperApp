//
//  ImageCardView.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import Foundation
import UIKit

// MARK: - ImageCardView
final class ImageCardView: UIView {
    
    // MARK: - Views
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Variables
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
    }
    
    final func setupImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}

// MARK: - Helpers
extension ImageCardView {
    final func setImage(with url: String) {
        if let imageURL = URL(string: url) {
            print("image URL \(url)")
        }
    }
}
