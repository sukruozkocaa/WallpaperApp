//
//  HomeViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import UIKit

extension String {
    var localized: String {
      return NSLocalizedString(self, comment: "\(self)_comment")
    }
}

// MARK: - HomeViewController
final class HomeViewController: UIViewController {

    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageListCollectionViewCell.self)
        collectionView.contentInset.top = 1.0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var layout: PinterestLayout = {
        let layout = PinterestLayout()
        layout.delegate = self
        return layout
    }()
    
    private var separatorLineView: UIView!
    
    // MARK: - Variables
    var categoryType: CategoryTypes?
    private var model: HomeViewModel?
    
    // MARK: - Constants
    private let minHeightArea = 250.0
    private let maxHeightArea = 400.0
    private let cellXMargin = 1.0
    private let cellYMargin = 1.0
    private let collectionViewNumberOfColumns = 2
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        model = HomeViewModel()
        model?.getPexelsResponse(categoryType: categoryType, page: 10)
        
        model?.reloadHandler = {
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Home_page_navigation_title".localized
        setupNavigationBarSeparatorLineView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        separatorLineView.removeFromSuperview()
    }
}

// MARK: - Setup UI
private extension HomeViewController {
    final func setupUI() {
        view.backgroundColor = Theme.Color.backgroundColor
        navigationController?.navigationBar.backgroundColor = Theme.Color.backgroundColor
        navigationController?.navigationBar.barStyle = .black
        setupViews()
    }
    
    final func setupNavigationBarSeparatorLineView() {
        if let navigationBar = navigationController?.navigationBar {
            let separatorHeight: CGFloat = 0.5
            let separatorLineView = UIView(frame: CGRect(
                x: 0,
                y: navigationBar.frame.height,
                width: navigationBar.frame.width,
                height: separatorHeight)
            )
            separatorLineView.backgroundColor = .lightGray
            navigationBar.addSubview(separatorLineView)
            self.separatorLineView = separatorLineView
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
        return model?.pexelsItemList.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: ImageListCollectionViewCell.self, for: indexPath)
        guard let item =  model?.pexelsItemList.value?[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(item: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item =  model?.pexelsItemList.value?[indexPath.row],
              let cell = collectionView.cellForItem(at: indexPath) as? ImageListCollectionViewCell else { return }
        pushToImageDetailViewController(imageURL: item.src?.original, cell: cell)
    }
}

// MARK: - Routers
private extension HomeViewController {
    final func pushToImageDetailViewController(imageURL: String?, cell: ImageListCollectionViewCell) {
        let imageDetailVC = ImageDetailViewController(image: cell.imageCardView.imageView.image)
        imageDetailVC.setZoomTransition(originalView: cell)
        self.present(imageDetailVC, animated: true)
    }
}

// MARK: - PinterestLayoutDelegate
extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return .random(in: minHeightArea...maxHeightArea)
    }
}

