//
//  UIViewController+Extension .swift
//  WallpaperApp
//
//  Created by Şükrü on 4.10.2024.
//

import Foundation
import UIKit
import IHProgressHUD

// MARK: - Progress Bar Configure 
extension UIViewController {
    func showProgressView() {
        IHProgressHUD.show()
    }
    
    func hideProgressView() {
        IHProgressHUD.dismiss()
    }
}
