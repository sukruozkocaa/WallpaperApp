//
//  HomeViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import UIKit

// MARK: - HomeViewController
final class HomeViewController: UIViewController {

    // MARK: - Views
    private lazy var backButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "lessthan.circle",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0)
            ),
            style: .plain, target: self,
            action: #selector(tapToBack)
        )
        barButtonItem.tintColor = .black
        return barButtonItem
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg_NeonLight")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    var categoryId: String?
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
        callToViewModelForUIUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .automatic
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
    final func callToViewModelForUIUpdate() {
        model = HomeViewModel()
        model?.getPexelsResponse(categoryId: categoryId, page: 50)
        
        model?.reloadHandler = {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Setup Views
private extension HomeViewController {
    final func setupViews() {
//        setupBackgroundImageView()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    final func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
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
        return model?.pexelsItemList.value?.media?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: ImageListCollectionViewCell.self, for: indexPath)
        guard let item =  model?.pexelsItemList.value?.media?[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(item: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item =  model?.pexelsItemList.value?.media?[indexPath.row],
              let cell = collectionView.cellForItem(at: indexPath) as? ImageListCollectionViewCell else { return }
        pushToImageDetailViewController(imageURL: item.src?.original, cell: cell)
    }
}

// MARK: - Routers
private extension HomeViewController {
    final func pushToImageDetailViewController(imageURL: String?, cell: ImageListCollectionViewCell) {
        let imageDetailVC = ImageDetailViewController(image: cell.imageCardView.imageView.image)
        imageDetailVC.setZoomTransition(originalView: cell.imageCardView.imageView)
        self.present(imageDetailVC, animated: true)
    }
}

// MARK: - PinterestLayoutDelegate
extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return .random(in: minHeightArea...maxHeightArea)
    }
}

// MARK: - Tap To Handlers
@objc
private extension HomeViewController {
    final func tapToBack() {
        navigationController?.popViewController(animated: true)
    }
}
