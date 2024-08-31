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
    private(set) var categoryList = Observable<CategoryListDataModel>()
    
    var reloadHandler: (() -> Void)? = nil
    
    init(apiCaller: APICallerProtocol = APICaller()) {
        self.apiCaller = apiCaller
    }
    
    // MARK: - Get Pexels Response
    final func getCategoryList() {
        apiCaller.apiCallerCategoryList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.categoryList.value = success
                getCategoryDetails()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    final func getCategoryDetail(categoryId: String) {
        apiCaller.apiCallerCategoryDetail(categoryId: categoryId, count: "5") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if let index = categoryList.value?.collections?.firstIndex(where: {$0.id == success.id}) {
                    categoryList.value?.collections?[index].photoList = success.media
                    reloadHandler?()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    final func getCategoryDetails() {
        categoryList.value?.collections?.forEach({ collection in
            DispatchQueue.main.async {
                self.getCategoryDetail(categoryId: collection.id ?? "")
            }
        })
    }
}

private extension CategoryViewModel {

}
