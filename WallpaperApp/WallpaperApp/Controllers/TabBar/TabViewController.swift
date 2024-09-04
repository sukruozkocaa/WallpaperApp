//
//  TabViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 2.09.2024.
//

import Foundation
import UIKit

open class TabViewController: UITabBarController {
    // MARK: - Views
    private lazy var cardTabBar = CardTabBarView()

    // MARK: - Properties
    open override var selectedIndex: Int {
        didSet {
            cardTabBar.select(at: selectedIndex)
        }
    }

    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(cardTabBar, forKey: "tabBar")
    }
}

extension TabViewController {
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item),
              let controller = viewControllers?[index] else { return }
        
        selectedIndex = index
        delegate?.tabBarController?(self, didSelect: controller)
    }
}
