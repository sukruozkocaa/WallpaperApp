//
//  CategoryViewModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 28.08.2024.
//

import Foundation

// MARK: - HomeViewModel
final class CategoryViewModel {
    private let apiCaller: APICallerProtocol
    private(set) var categoryList = Observable<[Photo]>()
    
    var reloadHandler: (() -> Void)? = nil
    
    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }

    // MARK: - Get Pexels Response
    final func getPexelsResponse(categoryTypes: [CategoryTypes]) {
        categoryTypes.forEach { type in
            DispatchQueue.main.async {
                self.apiCaller.apiCallerCategoryList(categoryType: type) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let success):
                        setupCategoryResponse(data: success.photos?.first)
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

private extension CategoryViewModel {
    final func setupCategoryResponse(data: Photo?) {
        guard let data = data else { return }
        if categoryList.value == nil {
            categoryList.value = []
        }
        
        categoryList.value?.append(data)
        
        if categoryList.value?.count == CategoryTypes.allCases.count {
            reloadHandler?()
        }
    }
}
