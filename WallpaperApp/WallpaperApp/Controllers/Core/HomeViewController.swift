//
//  HomeViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import UIKit
import IHProgressHUD

// MARK: - HomeViewController
final class HomeViewController: BaseViewController {

    // MARK: - Views
    private lazy var backButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "lessthan.circle",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: backButtonPointSize)
            ), style: .plain, target: self, action: #selector(tapToBack))
        barButtonItem.tintColor = .white
        return barButtonItem
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.contentInset.bottom = 20.0
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
    
    private var separatorLineView: UIView!
    
    // MARK: - Variables
    var categoryId: String?
    private var viewModel: HomeViewModelProtocol
    private var router: HomeRouterProtocol
    
    // MARK: - Constants
    private let minHeightArea: CGFloat = 250.0
    private let maxHeightArea: CGFloat = 400.0
    private let cellXMargin: CGFloat = 1.0
    private let cellYMargin: CGFloat = 1.0
    private let collectionViewNumberOfColumns: Int = 2
    private let collectionViewContentInsetTop: CGFloat = 1.0
    private let backButtonPointSize: CGFloat = 20.0
    
    // MARK: - Init
    init(categoryId: String? = nil, viewModel: HomeViewModelProtocol, router: HomeRouterProtocol) {
        self.categoryId = categoryId
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        IHProgressHUD.show()
        setupUI()
        viewModel.categoryId = categoryId
        viewModel.loadCategoryListItems()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.Color.backgroundColor
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - Setup UI
private extension HomeViewController {
    final func setupUI() {
        setupViews()
    }
}

// MARK: - Setup ViewModel
private extension HomeViewController {
    final func bindViewModel() {
        viewModel.reloadHandler = { [weak self] in
            guard let self else { return }
            IHProgressHUD.dismiss()
            self.collectionView.reloadData()
        }
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

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pexelsItemList.value?.media?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: ImageListCollectionViewCell.self, for: indexPath)
        guard let item = viewModel.pexelsItemList.value?.media?[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(item: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageListCollectionViewCell else { return }
        router.navigateToImageDetail(from: self, imageView: cell.imageCardView.imageView)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let collectionsCount = viewModel.pexelsItemList.value?.media?.count,
                 indexPath.section == collectionsCount - 2 else { return }
        
        viewModel.loadCategoryListItems()
    }
}

// MARK: - PinterestLayoutDelegate
extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let imageHeight = viewModel.pexelsItemList.value?.media?[indexPath.row].height
        return viewModel.getCollectionViewCellHeight(imageHeight: imageHeight)
    }
}

// MARK: - Tap To Handlers
@objc
private extension HomeViewController {
    final func tapToBack() {
        router.navigateToPopViewController(from: self)
    }
    
    final func swipeToRefresh() {
        viewModel.removeAllItems()
        refreshController.endRefreshing()
    }
}
