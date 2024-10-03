//
//  CategoryDetailReusableView.swift
//  WallpaperApp
//
//  Created by Şükrü on 30.08.2024.
//

import UIKit

// MARK: - CategoryDetailReusableView
final class CategoryDetailReusableView: UICollectionReusableView {
        
    // MARK: - Views
    private lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("CategoryDetailReusableView_button.title" .localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Constants
    private let buttonHeight: CGFloat = 50.0
    
    // MARK: - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSeeAllButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup Views
private extension CategoryDetailReusableView {
    final func setupSeeAllButton() {
        addSubview(seeAllButton)
        
        NSLayoutConstraint.activate([
            seeAllButton.widthAnchor.constraint(equalTo: widthAnchor),
            seeAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeAllButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
}
