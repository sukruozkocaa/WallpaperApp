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
    private(set) var pexelsItemList = Observable<[Photo]>()

    var reloadHandler: (() -> Void)? = nil
    
    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }

    // MARK: - Get Pexels Response
    final func getPexelsResponse(categoryType: CategoryTypes?, page: Int) {
        apiCaller.apiCallerForSearch(categoryType: categoryType, page: page) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let success):
                    self.setupPexelsResponse(data: success)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.pexelsItemList.value = []
                }
                self.reloadHandler?()
            }
        }
        
    }
}

private extension HomeViewModel {
    final func setupPexelsResponse(data: PexelsResponse?) {
        pexelsItemList.value = data?.photos
        reloadHandler?()
    }
}
