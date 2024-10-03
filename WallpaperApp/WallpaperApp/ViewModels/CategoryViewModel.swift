//
//  CategoryViewModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 28.08.2024.
//

import Foundation

protocol CategoryViewModelProtocol: AnyObject {
    var categoryList: Observable<CategoryListDataModel> { get }
    var reloadHandler: (() -> Void)? { get set }
    var categoryCellDataSource: Observable<CategoryListCollection> { get }
    func loadCategoryList()
    func getCategoryDetails(completion: @escaping () -> Void)
}

// MARK: - HomeViewModel
final class CategoryViewModel: CategoryViewModelProtocol {
    
    // MARK: - Variables
    private let apiCaller: APICallerProtocol
    internal var categoryCellDataSource = Observable<CategoryListCollection>()
    private let maxCategoryCount: Int = 20
    private var nextPageURL: String? = nil
    private(set) var categoryList = Observable<CategoryListDataModel>()
    var reloadHandler: (() -> Void)? = nil

    // MARK: - Life Cycle
    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }
    
    // MARK: - Get Pexels Response
    final func loadCategoryList() {
        if let currentCount = categoryList.value?.collections?.count, currentCount <= maxCategoryCount {
            return
        }
        
        apiCaller.apiCallerCategoryList(nextPageURL: self.nextPageURL) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let value):
                self.nextPageURL = value.next_page
                setupCategoryItems(item: value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    final func getCategoryDetails(completion: @escaping () -> ()) {
        let group = DispatchGroup()
        categoryList.value?.collections?.forEach({ collection in
            group.enter()
            
            self.getCategoryDetail(categoryId: collection.id ?? "") {
                group.leave()
            }
            
            group.notify(queue: .main) {
                completion()
            }
        })
    }
    
    final func getCategoryDetail(categoryId: String, completion: @escaping () -> ()) {
        apiCaller.apiCallerCategoryDetail(categoryId: categoryId, count: "5") { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let success):
                if let index = categoryList.value?.collections?.firstIndex(where: {$0.id == success.id}) {
                    categoryList.value?.collections?[index].photoList = success.media
                }
                completion()
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
}

// MARK: - Response Configure
private extension CategoryViewModel {
    final func setupCategoryItems(item: CategoryListDataModel?) {
        guard let newCollections = item?.collections else { return }
              
        if categoryList.value?.collections == nil {
            categoryList.value = item
        } else {
            categoryList.value?.collections?.append(contentsOf: newCollections)
        }
              
        getCategoryDetails { [weak self] in
            self?.reloadHandler?()
        }
    }
    
    final func handleError(_ error: Error) {
        // Handle errors here, e.g., by notifying a delegate or updating an error state
        print(error.localizedDescription)
    }
}
