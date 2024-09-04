//
//  HomeRouter.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.09.2024.
//

import Foundation
import UIKit

protocol HomeRouterProtocol: AnyObject {
    func navigateToPopViewController(from viewController: UIViewController)
    func navigateToImageDetail(from viewController: UIViewController, imageView: UIImageView)
}

class HomeRouter: HomeRouterProtocol {
    func navigateToPopViewController(from viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }

    func navigateToImageDetail(from viewController: UIViewController, imageView: UIImageView) {
        guard let image = imageView.image else { return }
        let imageDetailVC = ImageDetailViewController(image: image)
        imageDetailVC.setZoomTransition(originalView: imageView)
        viewController.present(imageDetailVC, animated: true)
    }
}

