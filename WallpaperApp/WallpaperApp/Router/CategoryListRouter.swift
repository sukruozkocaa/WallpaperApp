//
//  CategoryListRouter.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.09.2024.
//

import Foundation
import UIKit

protocol CategoryListRouterProtocol: AnyObject {
    func navigateToHomeViewController(from viewController: UIViewController, with categoryId: String?, categoryName: String?)
    func navigateToImageDetail(from viewController: UIViewController, imageView: UIImageView)
}

class CategoryListRouter: CategoryListRouterProtocol {
    func navigateToHomeViewController(from viewController: UIViewController, with categoryId: String?, categoryName: String?) {
        let homeVC = CategoryDetailViewController(categoryId: categoryId ?? "")
        homeVC.navigationItem.title = categoryName
        viewController.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func navigateToImageDetail(from viewController: UIViewController, imageView: UIImageView) {
        guard let image = imageView.image else { return }
        let imageDetailVC = ImageDetailViewController(image: image)
        imageDetailVC.setZoomTransition(originalView: imageView)
        viewController.present(imageDetailVC, animated: true)
    }
}
