//
//  HomeViewModelProtocol.swift
//  WallpaperApp
//
//  Created by Şükrü on 3.10.2024.
//

import Foundation

// MARK: - CategoryDetailViewModelProtocol
protocol CategoryDetailViewModelProtocol: AnyObject, ViewModel {
//    func viewDidLoad(from output: HomesViewModelOutputProtocol)
}

// MARK: - CategoryDetailViewModelOutputProtocol
protocol CategoryDetailViewModelOutputProtocol: AnyObject {
    func categoryDetailViewModelOutputProtocol(loadData: CategoryDetailDataModel?)
    func categoryDetailViewModelOutputProtocol(showProgressView: Bool)
}
