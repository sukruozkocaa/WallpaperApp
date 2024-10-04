//
//  CategoryListViewModelProtocol.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.10.2024.
//

import Foundation

// MARK: - CategoryListViewModelProtocol
protocol CategoryListViewModelProtocol: AnyObject, ViewModel {
    
}

// MARK: - CategoryListViewModelOutputProtocol
protocol CategoryListViewModelOutputProtocol: AnyObject {
    func categoryListViewModelOutputProtocol(loadData: CategoryListDataModel?)
    func categoryListViewModelOutputProtocol(showProgressView: Bool)
    func categoryListViewModelOutputProtocol(reloadData: Any)
}
