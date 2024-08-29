//
//  CategoryListViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 28.08.2024.
//

import UIKit

// MARK: - CategoryListViewController
final class CategoryListViewController: UIViewController {

    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 4.0, bottom: 0, right: 4.0)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryListCollectionViewCell.self)
        collectionView.contentInset.top = 1.0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4.0
        layout.minimumInteritemSpacing = 4.0
        layout.scrollDirection = .vertical
        return layout
    }()
    
    // MARK: - Variables
    var model: CategoryViewModel?
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        model = CategoryViewModel()
        
        model?.getPexelsResponse(categoryTypes: CategoryTypes.allCases)
        
        model?.reloadHandler = {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Setup Views
private extension CategoryListViewController {
    final func setupViews() {
        view.backgroundColor = Theme.Color.backgroundColor
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
        collectionView.collectionViewLayout = collectionViewLayout
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension CategoryListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.categoryList.value?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = model?.categoryList.value?[indexPath.row] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(for: CategoryListCollectionViewCell.self, for: indexPath)
        let title = CategoryTypes.allCases[indexPath.row].title ?? ""
        cell.configure(title: title, image: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 6, height: (view.frame.width / 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = CategoryTypes.allCases[indexPath.row]
        pushToHomeViewController(categoryType: type)
    }
}

// MARK: - Routers
private extension CategoryListViewController {
    final func pushToHomeViewController(categoryType: CategoryTypes) {
        let homeVC = HomeViewController()
        homeVC.categoryType = categoryType
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
