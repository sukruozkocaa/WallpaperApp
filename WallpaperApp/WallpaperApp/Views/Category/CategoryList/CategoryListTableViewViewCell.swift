//
//  CategoryListTableViewViewCell.swift
//  WallpaperApp
//
//  Created by Şükrü on 28.08.2024.
//

import UIKit

// MARK: - CategoryListTableViewViewCellDelegate
protocol CategoryListTableViewViewCellDelegate: AnyObject {
    func categoryListTableViewViewCell(
        _ cell: CategoryListTableViewViewCell,
        _ categoryId: String?,
        _ categoryName: String
    )
    func categoryListTableViewViewCell(_ cell: CategoryListTableViewViewCell, _ onTapImageView: UIImageView)
}

// MARK: - CategoryListCollectionViewCell
final class CategoryListTableViewViewCell: UITableViewCell {
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryDetailCollectionViewCell.self)
        collectionView.register(supplementaryView: CategoryDetailReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(
            top: .zero,
            left: 24.0,
            bottom: .zero,
            right: 24.0
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        button.setTitleColor(UIColor(hexString: "#B6B6B6"), for: .normal)
        button.setTitle("CategoryListTableViewCell_button.title".localized, for: .normal)
        button.addTarget(self, action: #selector(tapToSeeAll), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150.0, height: 250.0)
        return layout
    }()

    // MARK: - Variables
    private var categoryId: String?
    private var categoryMediaList: [CategoryMediaDataModel]?
    weak var delegate: CategoryListTableViewViewCellDelegate?
    
    // MARK: - Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup Views
private extension CategoryListTableViewViewCell {
    final func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupCollectionView()
        setupTitleLabel()
        setupSeeAllButton()
    }
    
    final func setupCollectionView() {
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 250.0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.collectionViewLayout = layout
    }
    
    final func setupTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10.0)
        ])
    }
    
    final func setupSeeAllButton() {
        addSubview(seeAllButton)
        
        NSLayoutConstraint.activate([
            seeAllButton.heightAnchor.constraint(equalToConstant: 14.0),
            seeAllButton.widthAnchor.constraint(equalToConstant: 100.0),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
            seeAllButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10.0)
        ])
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension CategoryListTableViewViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryMediaList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: CategoryDetailCollectionViewCell.self, for: indexPath)
        if let item = categoryMediaList?[indexPath.row] {
            cell.configure(item: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryDetailCollectionViewCell else {
            return
        }

        delegate?.categoryListTableViewViewCell(self, cell.imageView)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: CategoryDetailReusableView.self, for: indexPath)
            return headerCell
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 150.0, height: collectionView.frame.height)
    }
}

// MARK: - Configure
extension CategoryListTableViewViewCell {
    final func configure(item: CategoryListCollection?) {
        categoryId = item?.id
        titleLabel.text = item?.title
        categoryMediaList = item?.photoList
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Tap To Handlers
@objc
private extension CategoryListTableViewViewCell {
    final func tapToSeeAll(_ sender: UIButton) {
        delegate?.categoryListTableViewViewCell(self, categoryId, titleLabel.text ?? "")
    }
}
