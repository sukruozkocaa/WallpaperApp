//
//  HomeViewModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 25.08.2024.
//

import Foundation

// MARK: - HomeViewModel
final class HomeViewModel {
    private let apiCaller: APICallerProtocol
    private var nextPageURL: String? = nil
    private(set) var pexelsItemList: CategoryDetailDataModel?
    
    var reloadHandler: (() -> Void)? = nil
    
    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }

    // MARK: - Get Pexels Response
    final func getPexelsResponse(categoryId: String?) {
        guard let categoryId = categoryId else { return }
        
        apiCaller.apiCallerCategoryItemsList(nextPageURL: nextPageURL, categoryId: categoryId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                nextPageURL = data.next_page
                
                setupPexelsResponse(data: data)
            case .failure(let fail):
                print(fail.localizedDescription)
                break
            }
        }
    }
}

private extension HomeViewModel {
    final func setupPexelsResponse(data: CategoryDetailDataModel?) {
        guard var existingItemList = pexelsItemList else {
            pexelsItemList = data
            reloadHandler?()
            return
        }
        
        guard let newMedia = data?.media else { return }
        existingItemList.media?.append(contentsOf: newMedia)
        pexelsItemList?.media = existingItemList.media
        reloadHandler?()
    }
}
