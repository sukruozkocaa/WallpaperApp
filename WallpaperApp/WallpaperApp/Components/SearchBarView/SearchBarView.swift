//
//  SearchBarView.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.09.2024.
//

import Foundation
import UIKit
 
// MARK: - SearchBarViewDelegate
protocol SearchBarViewDelegate: AnyObject {
    func search(text: String)
}

// MARK: - SearchBarView
final class SearchBarView: UIView {
    
    // MARK: - Views
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layer.borderWidth = 1.0
        stackView.layer.masksToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.layer.cornerRadius = 14.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_magnifyingGlass"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.textColor = .white
        textField.textAlignment = .left
        textField.keyboardType = .default
        textField.attributedPlaceholder = NSAttributedString(
            string: "Ara",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.addTarget(self, action: #selector(didCharacterIn), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - Variables
    weak var delegate: SearchBarViewDelegate?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views
private extension SearchBarView {
    final func setupViews() {
        setupContainerStackView()
        setupSearchButton()
        setupDividerView()
        setupSearchTextField()
    }
    
    final func setupContainerStackView() {
        addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.widthAnchor.constraint(equalTo: widthAnchor),
            containerStackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    final func setupSearchButton() {
        containerStackView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 60.0),
            searchButton.heightAnchor.constraint(equalTo: containerStackView.heightAnchor)
        ])
    }
    
    final func setupDividerView() {
        containerStackView.addArrangedSubview(dividerView)
        
        NSLayoutConstraint.activate([
            dividerView.widthAnchor.constraint(equalToConstant: 1.0),
            dividerView.heightAnchor.constraint(equalTo: containerStackView.heightAnchor)
        ])
    }
    
    final func setupSearchTextField() {
        containerStackView.setCustomSpacing(15.0, after: dividerView)
        containerStackView.addArrangedSubview(searchTextField)
    }
}

// MARK: - Tap To Handlers
@objc
private extension SearchBarView {
    func didCharacterIn() {
        delegate?.search(text: searchTextField.text ?? "")
    }
}
