//
//  SearchViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.09.2024.
//

import UIKit
import IHProgressHUD

// MARK: - SearchViewController
final class SearchViewController: BaseViewController {
    
    // MARK: - Views
    private lazy var searchBarView: SearchBarView = {
        let view = SearchBarView()
        view.delegate = self
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.contentInset.bottom = 20.0
        collectionView.contentInset.top = 12.0
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(SearchListCollectionViewCell.self)
        collectionView.register(EmptyDataCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var refreshController: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(swipeToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .vertical
        return layout
    }()
    
    // MARK: - Variables
    private var viewModel: SearchViewModelProtocol
    private var searchTimer: Timer?

    // MARK: - Constants
    private let searchBarHeight: CGFloat = 50.0
    
    // MARK: - Life Cycles
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IHProgressHUD.show()
        setupViews()
        viewModel.loadSearchQueryItems(searchText: "life")
        bindViewModel()
    }
    
}

// MARK: - Setup Views
private extension SearchViewController {
    final func setupViews() {
        setupSearchBarView()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    final func setupSearchBarView() {
        view.addSubview(searchBarView)
        
        NSLayoutConstraint.activate([
            searchBarView.heightAnchor.constraint(equalToConstant: searchBarHeight),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24.0)
        ])
    }
    
    final func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 12.0)
        ])
        
        collectionView.refreshControl = refreshController
    }
    
    final func setupCollectionViewLayout() {
        collectionView.collectionViewLayout = collectionViewLayout
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard viewModel.searchItems.value?.photos?.count ?? 0 > 0 else {
            if viewModel.searchItems.value == nil {
                return .zero
            }
            
            return 1
        }
        
        return viewModel.searchItems.value?.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard viewModel.searchItems.value?.photos?.count ?? 0 > 0 else {
            if viewModel.searchItems.value == nil {
                return UICollectionViewCell()
            }
            
            let emptyCell = collectionView.dequeueReusableCell(for: EmptyDataCollectionViewCell.self, for: indexPath)
            return emptyCell
        }
        
        guard let item = viewModel.searchItems.value?.photos?[indexPath.row] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(for: SearchListCollectionViewCell.self, for: indexPath)
        cell.configure(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.searchItems.value?.photos?.count ?? 0) - 2 {
            viewModel.loadSearchQueryItems(searchText: viewModel.searchText)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard viewModel.searchItems.value?.photos?.count ?? 0 > 0 else {
            if viewModel.searchItems.value == nil {
                return .zero
            }
            
            return CGSize(width: collectionView.frame.width, height: 300.0)
        }
        
        return CGSize(width: (collectionView.frame.width / 2), height: view.frame.height * 0.45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SearchListCollectionViewCell
        guard let image = cell.imageCardView.imageView.image else { return }
        let imageDetailVC = ImageDetailViewController(image: image)
        imageDetailVC.setZoomTransition(originalView: cell.imageCardView.imageView)
        present(imageDetailVC, animated: true)
    }
}

// MARK: - SearchBar TextField Delegate
extension SearchViewController: SearchBarViewDelegate {
    func search(text: String) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self else { return }
            viewModel.progressControl(visible: true)
            
            let searchText: String
            if text == "" {
                searchText = "life"
            } else {
                searchText = text
            }
            
            viewModel.loadSearchQueryItems(searchText: searchText)
        }
    }
}

// MARK: - Tap To Handlers
@objc
private extension SearchViewController {
    final func swipeToRefresh() {
        viewModel.removeAllItems()
        refreshController.endRefreshing()
    }
}

// MARK: - Setup ViewModel
private extension SearchViewController {
    final func bindViewModel() {
        viewModel.reloadHandler = { [weak self] in
            guard let self else { return }
            IHProgressHUD.dismiss()
            self.collectionView.reloadData()
        }
    }
}
