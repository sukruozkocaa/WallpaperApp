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
    private(set) var pexelsItemList = Observable<CategoryDetailDataModel>()

    var reloadHandler: (() -> Void)? = nil
    
    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }

    // MARK: - Get Pexels Response
    final func getPexelsResponse(categoryId: String?, page: Int) {
        guard let categoryId = categoryId else { return }
        apiCaller.apiCallerCategoryDetail(categoryId: categoryId, count: "30") { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.setupPexelsResponse(data: success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.reloadHandler?()
            }
        }
    }
}

private extension HomeViewModel {
    final func setupPexelsResponse(data: CategoryDetailDataModel?) {
        pexelsItemList.value = data
        reloadHandler?()
    }
}
