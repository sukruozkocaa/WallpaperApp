//
//  HomeViewModelProtocol.swift
//  WallpaperApp
//
//  Created by Şükrü on 3.10.2024.
//

import Foundation

// MARK: - ViewModel
public protocol ViewModel {
    var showErrorMessage: ((_ errorMessage: String)->Void)? { get set }
    var dismissErrorMessage: (()->Void)? { get set }
}

protocol CategoryDetailViewModelProtocol: AnyObject, ViewModel {
//    func viewDidLoad(from output: HomesViewModelOutputProtocol)
}

protocol CategoryDetailViewModelOutputProtocol: AnyObject {
    func homeViewModelOutputProtocol(loadData: CategoryDetailDataModel?)
    func homeViewModelOutputProtocol(showProgressView: Bool)
}
