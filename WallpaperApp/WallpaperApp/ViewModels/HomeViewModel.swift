//
//  HomeViewModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 25.08.2024.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var categoryId: String? { get set}
    var pexelsItemList: Observable<CategoryDetailDataModel> { get }
    var reloadHandler: (() -> Void)? { get set }
    func loadCategoryListItems()
    func removeAllItems()
    func getCollectionViewCellHeight(imageHeight: Int?) -> CGFloat
}

// MARK: - HomeViewModel
final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Private Variables
    private let apiCaller: APICallerProtocol
    private var nextPageURL: String? = nil
    private(set) var pexelsItemList = Observable<CategoryDetailDataModel>()
    private var imageHeightArea: CGFloat = 0.07
    
    // MARK: - Public Variables
    var categoryId: String?
    var reloadHandler: (() -> Void)? = nil

    // MARK: - Life Cycle
    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }

    // MARK: - Get Pexels Response
    final func loadCategoryListItems() {
        guard let categoryId = categoryId else { return }
        
        apiCaller.apiCallerCategoryItemsList(
            nextPageURL: nextPageURL,
            categoryId: categoryId) 
        { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                nextPageURL = data.next_page
                setupPexelsResponse(data: data)
            case .failure(let error):
                handleError(error)
            }
        }
    }
    
    final func removeAllItems() {
        nextPageURL = nil
        pexelsItemList.value = nil
        loadCategoryListItems()
    }
    
    final func getCollectionViewCellHeight(imageHeight: Int?) -> CGFloat {
        guard let imageHeight = imageHeight else { return .zero}
        return CGFloat(imageHeight) * imageHeightArea
    }
}

// MARK: - Response Configure
private extension HomeViewModel {
    final func setupPexelsResponse(data: CategoryDetailDataModel?) {
        guard let newdata = data?.media else { return }
              
        if pexelsItemList.value == nil {
            pexelsItemList.value = data
        } else {
            pexelsItemList.value?.media?.append(contentsOf: newdata)
        }
              
        self.reloadHandler?()
    }
    
    final func handleError(_ error: Error) {
        // Handle errors here, e.g., by notifying a delegate or updating an error state
        print(error.localizedDescription)
    }
}
