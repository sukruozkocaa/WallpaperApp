//
//  ViewModel.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.10.2024.
//

import Foundation

// MARK: - ViewModel
public protocol ViewModel {
    var showErrorMessage: ((_ errorMessage: String)->Void)? { get set }
    var dismissErrorMessage: (()->Void)? { get set }
}
