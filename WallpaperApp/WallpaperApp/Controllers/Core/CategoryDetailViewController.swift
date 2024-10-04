//
//  CategoryDetailViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 3.10.2024.
//

import UIKit

// MARK: - CategoryDetailViewController
final class CategoryDetailViewController: ViewController<CategoryDetailViewModel> {
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.top = collectionViewContentInsetTop
        collectionView.register(ImageListCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var refreshController: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(swipeToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var layout: PinterestLayout = {
        let layout = PinterestLayout()
        layout.delegate = self
        return layout
    }()
    
    // MARK: - Variables
    var categoryId: String
    private let cellXMargin: CGFloat = 1.0
    private let cellYMargin: CGFloat = 1.0
    private let collectionViewNumberOfColumns: Int = 2
    private var router: CategoryListRouterProtocol = CategoryListRouter()

    // MARK: - Constants
    private let collectionViewContentInsetTop: CGFloat = 1.0
    
    init(categoryId: String) {
        self.categoryId = categoryId
        super.init(viewModel: CategoryDetailViewModel())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad(from: self, categoryId: categoryId)
    }
}

// MARK: - Setup UI
private extension CategoryDetailViewController {
    final func setupUI() {
        setupViewUI()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    final func setupViewUI() {
        view.backgroundColor = Theme.Color.backgroundColor
    }
    
    final func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        collectionView.refreshControl = refreshController
    }
    
    final func setupCollectionViewLayout() {
        layout.cellXMargin = cellXMargin
        layout.cellYMargin = cellYMargin
        layout.numberOfColumns = collectionViewNumberOfColumns
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - UICollectionViewDelegate
extension CategoryDetailViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryListCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.cellForItemAt(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.categoryListCount - 2 {
            viewModel.nextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageListCollectionViewCell else { return }
        router.navigateToImageDetail(from: self, imageView: cell.imageCardView.imageView)
    }
}

// MARK: - PinterestLayoutDelegate
extension CategoryDetailViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return viewModel.calculateCellHeight(indexPath: indexPath)
    }
}

// MARK: - HomesViewModelOutputProtocol
extension CategoryDetailViewController: CategoryDetailViewModelOutputProtocol {
    func categoryDetailViewModelOutputProtocol(showProgressView: Bool) {
        showProgressView == true ? self.showProgressView() : self.hideProgressView()
    }
    
    func categoryDetailViewModelOutputProtocol(loadData: CategoryDetailDataModel?) {
        refreshController.endRefreshing()
        collectionView.reloadData()
    }
}

// MARK: - Objc
@objc
private extension CategoryDetailViewController {
    final func swipeToRefresh() {
        refreshController.beginRefreshing()
        viewModel.swipeToRefresh()
    }
}

