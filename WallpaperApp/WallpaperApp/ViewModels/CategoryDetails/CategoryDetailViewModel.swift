//
//  CategoryDetailViewModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 25.08.2024.
//

import Foundation
import UIKit
 
// MARK: - CategoryDetailViewModel
final class CategoryDetailViewModel: CategoryDetailViewModelProtocol {
    
    // MARK: - Base
    var showErrorMessage: ((String) -> Void)?
    var dismissErrorMessage: (() -> Void)?
    
    // MARK: - Non Protocol Properties
    private var apiCaller: APICallerProtocol?
    private var categoryId: String?
    private var nextPageURL: String? = nil
    private var imageHeightArea: CGFloat = 0.07

    private var categoryDetail: CategoryDetailDataModel? {
        didSet {
            didCategoryListResponseChanged()
        }
    }
    
    // Delegates
    private weak var delegate: CategoryDetailViewModelOutputProtocol?
    
    // MARK: - Initializers
    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }
    
    init(categoryId: String) {
        self.categoryId = categoryId
    }
    
}

// MARK: - Protocol Functions
extension CategoryDetailViewModel {
    func viewDidLoad(from output: CategoryDetailViewModelOutputProtocol, categoryId: String) {
        self.categoryId = categoryId
        delegate = output
        
        delegate?.categoryDetailViewModelOutputProtocol(showProgressView: true)
        requestCategoryDetails()
    }
    
    var categoryListCount: Int {
        guard let items = categoryDetail?.media else { return .zero }
        return items.count
    }
    
    func cellForItemAt(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: ImageListCollectionViewCell.self, for: indexPath)
        guard let item = categoryDetail?.media?[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(item: item)
        return cell
    }
    
    func calculateCellHeight(indexPath: IndexPath) -> CGFloat {
        let responseImageHeight = categoryDetail?.media?[indexPath.row].height ?? .zero
        let height = CGFloat(responseImageHeight) * imageHeightArea
        return height
    }
    
    func swipeToRefresh() {
        nextPageURL = nil
        categoryDetail = nil
        requestCategoryDetails()
    }
    
    func nextPage() {
        requestCategoryDetails()
    }
    
    func handleSuccessResponse(_ response: CategoryDetailDataModel) {
        nextPageURL = response.next_page

        if categoryDetail == nil {
            categoryDetail = response
        } else if let media = response.media {
            categoryDetail?.media?.append(contentsOf: media)
        }
    }
}

// MARK: - Network
private extension CategoryDetailViewModel {
    final func requestCategoryDetails() {
        guard let categoryId = categoryId else { return }
            
        apiCaller?.apiCallerCategoryItemsList(nextPageURL: nextPageURL, categoryId: categoryId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                handleSuccessResponse(response)
            case .failure(let error):
                self.showErrorMessage?(error.localizedDescription)
            }
        }
    }
}

// MARK: - Configure
private extension CategoryDetailViewModel {
    final func didCategoryListResponseChanged() {
        handleCollectionViewConfigure()
    }
    
    final func handleCollectionViewConfigure() {
        delegate?.categoryDetailViewModelOutputProtocol(loadData: categoryDetail)
        delegate?.categoryDetailViewModelOutputProtocol(showProgressView: false)
    }
}

