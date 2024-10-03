//
//  EmptyDataCollectionViewCell.swift
//  WallpaperApp
//
//  Created by Şükrü on 8.09.2024.
//

import UIKit

// MARK: - EmptyDataCollectionViewCell
final class EmptyDataCollectionViewCell: UICollectionViewCell {
 
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Arama sonucu bulunamadı"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Girmiş olduğunuz bilgilere uygun görsel bulunamadı."
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Life Cycle
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
private extension EmptyDataCollectionViewCell {
    final func setupViews() {
        setupTitleLabel()
        setupSubTitleLabel()
    }
    
    final func setupTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0)
        ])
    }
    
    final func setupSubTitleLabel() {
        addSubview(subTitleLabel)
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0)
        ])
    }
}
