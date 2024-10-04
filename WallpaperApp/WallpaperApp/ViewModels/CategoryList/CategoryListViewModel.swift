//
//  CategoryListViewModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.10.2024.
//

import Foundation

// MARK: - CategoryListViewModel
final class CategoryListViewModel: CategoryListViewModelProtocol {

    // MARK: - Base
    var showErrorMessage: ((String) -> Void)?
    var dismissErrorMessage: (() -> Void)?
    
    // MARK: - Private
    private var apiCaller: APICallerProtocol?
    private var nextPageURL: String? = nil
    private weak var delegate: CategoryListViewModelOutputProtocol?
    private var categoryListResponse: CategoryListDataModel? {
        didSet {
            didCategoryListResponseChanged()
        }
    }
    
    // MARK: - Public
    var categoryListResponseItems: [CategoryListCollection] {
        return categoryListResponse?.collections ?? []
    }
 
    // MARK: - Init
    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }
}

// MARK: - Protocol Functions
extension CategoryListViewModel {
    final func viewDidLoad(from output: CategoryListViewModelOutputProtocol) {
        delegate = output
        
        delegate?.categoryListViewModelOutputProtocol(showProgressView: true)
        requestCategoryList()
    }
    
    func swipeToRefresh() {
        nextPageURL = nil
        categoryListResponse = nil
        requestCategoryList()
    }
    
    func nextPage() {
        requestCategoryList()
    }
    
    func handleSuccessResponse(_ response: CategoryListDataModel) {
        nextPageURL = response.next_page

        if categoryListResponse == nil {
            categoryListResponse = response
        } else if let media = response.collections {
            categoryListResponse?.collections?.append(contentsOf: media)
        }
        
        getCategoryDetails { [weak self] in
            guard let self else { return }
            delegate?.categoryListViewModelOutputProtocol(reloadData: self)
        }
    }
    
    final func getCategoryDetails(completion: @escaping () -> ()) {
        let group = DispatchGroup()
        categoryListResponse?.collections?.forEach({ collection in
            group.enter()
            
            self.requestCategoryDetail(categoryId: collection.id ?? "") {
                group.leave()
            }
            
            group.notify(queue: .main) {
                completion()
            }
        })
    }
}

// MARK: - Network
private extension CategoryListViewModel {
    final func requestCategoryList() {
        apiCaller?.apiCallerCategoryList(nextPageURL: self.nextPageURL, completion: { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                handleSuccessResponse(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    final func requestCategoryDetail(categoryId: String, completion: @escaping () -> ()) {
        apiCaller?.apiCallerCategoryDetail(categoryId: categoryId, count: "5") { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let success):
                if let index = categoryListResponse?.collections?.firstIndex(where: {$0.id == success.id}) {
                    categoryListResponse?.collections?[index].photoList = success.media
                }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Configure
private extension CategoryListViewModel {
    final func didCategoryListResponseChanged() {
        handleCollectionViewConfigure()
    }
    
    final func handleCollectionViewConfigure() {
        delegate?.categoryListViewModelOutputProtocol(loadData: categoryListResponse)
        delegate?.categoryListViewModelOutputProtocol(showProgressView: false)
    }
}
