//
//  SearchViewModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.09.2024.
//

import Foundation
import IHProgressHUD

// MARK: - SearchListDataModelProtocol
protocol SearchViewModelProtocol: AnyObject {
    var searchItems: Observable<PexelsResponse> { get }
    var reloadHandler: (() -> Void)? { get set }
    var searchText: String? { get set }
    func progressControl(visible: Bool)
    func loadSearchQueryItems(searchText: String?)
    func removeAllItems()
    func getCollectionViewCellHeight(imageHeight: Int?) -> CGFloat
}

final class SearchViewModel: SearchViewModelProtocol {
    
    // MARK: - Variables
    var searchText: String?
    private let apiCaller: APICallerProtocol
    private(set) var searchItems = Observable<PexelsResponse>()
    var reloadHandler: (() -> Void)? = nil
    private var nextPageURL: String? = nil
    private var imageHeightArea: CGFloat = 0.07

    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }
        
    func loadSearchQueryItems(searchText: String?) {    
        if self.searchText != searchText {
            self.searchText = searchText
            searchItems.value = nil
            nextPageURL = nil
        }
        
        apiCaller.apiCallerForSearch(searchText: searchText, nextPageURL: nextPageURL) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                nextPageURL = response.nextPage
                configureSearchResponse(data: response)
            case .failure(let error):
                handleError(error)
            }
        }
    }
    
    func removeAllItems() {
        searchItems.value = nil
        nextPageURL = nil
        reloadHandler?()
        loadSearchQueryItems(searchText: searchText)
    }
    
    func progressControl(visible: Bool) {
        if visible {
            if IHProgressHUD.isVisible() { return }
            IHProgressHUD.show()
            return
        }
        
        IHProgressHUD.dismiss()
    }
    
    func getCollectionViewCellHeight(imageHeight: Int?) -> CGFloat {
        guard let imageHeight = imageHeight else { return .zero}
        return CGFloat(imageHeight) * imageHeightArea
    }
    
    func scrollToTop() {
        
    }
    
}

// MARK: Response Configure
private extension SearchViewModel {
    final func configureSearchResponse(data: PexelsResponse?) {
        guard let newdata = data?.photos else { return }
              
        if searchItems.value == nil {
            searchItems.value = data
        } else {
            searchItems.value?.photos?.append(contentsOf: newdata)
        }
              
        self.reloadHandler?()
    }
    
    final func handleError(_ error: Error) {
        // Handle errors here, e.g., by notifying a delegate or updating an error state
        print(error.localizedDescription)
    }
}
