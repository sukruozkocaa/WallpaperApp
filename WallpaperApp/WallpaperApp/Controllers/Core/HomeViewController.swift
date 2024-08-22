//
//  HomeViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import UIKit

// MARK: - HomeViewController
final class HomeViewController: UIViewController {

    // MARK: - View
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageListCollectionViewCell.self)
        collectionView.contentInset = .zero
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var layout: PinterestLayout = {
        let layout = PinterestLayout()
        layout.delegate = self
        return layout
    }()
    
    // MARK: - Variables
    private let minHeightArea = 250.0
    private let maxHeightArea = 450.0
    private let cellXMargin = 1.0
    private let cellYMargin = 1.0
    private let collectionViewNumberOfColumns = 2
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI
private extension HomeViewController {
    final func setupUI() {
        view.backgroundColor = Theme.Color.white
        setupViews()
    }
}

// MARK: - Setup Views
private extension HomeViewController {
    final func setupViews() {
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    final func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    final func setupCollectionViewLayout() {
        layout.cellXMargin = cellXMargin
        layout.cellYMargin = cellYMargin
        layout.numberOfColumns = collectionViewNumberOfColumns
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - Network
private extension HomeViewController {
    
}

// MARK: - Helpers

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: ImageListCollectionViewCell.self, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}

// MARK: - PinterestLayoutDelegate
extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return .random(in: minHeightArea...maxHeightArea)
    }
}

