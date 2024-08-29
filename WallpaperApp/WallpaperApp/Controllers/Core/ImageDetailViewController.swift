//
//  ImageDetailViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 26.08.2024.
//

import UIKit

// MARK: - ImageDetailViewController
final class ImageDetailViewController: UIViewController {

    // MARK: - Views
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "lessthan.circle"), for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20.0
        button.tintColor = .white
        button.addTarget(self, action: #selector(tapToBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    // MARK: - Variables
    
    // MARK: - Init
    init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        setupViews()
    }
    
    // MARK: - Life Cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Navigation Bar
private extension ImageDetailViewController {
    final func setupNavigationBarBackButton() {
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 40.0),
            backButton.heightAnchor.constraint(equalToConstant: 40.0),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0)
        ])
    }
}

// MARK: - Setup Views
private extension ImageDetailViewController {
    final func setupViews() {
        setupImageView()
        setupNavigationBarBackButton()
    }
    
    final func setupImageView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}

// MARK: - Tap To Handlers
@objc
private extension ImageDetailViewController {
    final func tapToBackButton() {
        dismiss(animated: true)
    }
}
