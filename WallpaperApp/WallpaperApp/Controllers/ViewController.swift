//
//  ViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 3.10.2024.
//

import UIKit
import IHProgressHUD

// MARK: - BaseViewController
class ViewController<T: ViewModel>: UIViewController {

    // MARK: - Variables
    var viewModel: T
    
    // MARK: - Init
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        handleBaseViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - BaseViewModel Handlers
extension ViewController {
    func handleBaseViewModel() {
        viewModel.showErrorMessage = {[weak self] errorMessage in
            guard let self else { return }
            self.showErrorMessage(message: errorMessage)
        }
        
        viewModel.dismissErrorMessage = { [weak self] in
            guard let self else { return }
            self.dismissErrorMessage()
        }
    }
}

// MARK: - Progress Controller
extension ViewController {
    final func showErrorMessage(message: String?) {
        IHProgressHUD.showError(withStatus: message)
    }
    
    final func dismissErrorMessage() {
        IHProgressHUD.dismiss()
    }
}
