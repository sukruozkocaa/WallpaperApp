//
//  MainTabBarViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 2.09.2024.
//

import UIKit

// MARK: - MainTabBarViewController
final class MainTabBarViewController: TabViewController {

    // MARK: - ViewControllers
    private lazy var homeVC: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_home"), selectedImage: nil)
        let viewModel = CategoryViewModel(apiCaller: APICaller())
        let homeNavTab = NavigationController(rootViewController: CategoryListViewController(viewModel: viewModel))
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()
    
    private lazy var searchVC: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Search", image: UIImage(named: "ic_search"), selectedImage: nil)
        let viewModel = CategoryViewModel()
        let homeNavTab = NavigationController(rootViewController: CategoryListViewController(viewModel: viewModel))
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()
    
    private lazy var profileVC: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Profile", image: UIImage(named: "ic_profile"), selectedImage: nil)
        let viewModel = CategoryViewModel()
        let homeNavTab = NavigationController(rootViewController: CategoryListViewController(viewModel: viewModel))
        homeNavTab.tabBarItem = homeTabItem
        
        return homeNavTab
    }()
    
    lazy var moreTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "More", image: UIImage(named: "ic_settings"), selectedImage: nil)
        let viewModel = CategoryViewModel()
        let navController = NavigationController(rootViewController: CategoryListViewController(viewModel: viewModel))
        navController.tabBarItem = commentTabItem
        return navController
    }()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI
private extension MainTabBarViewController {
    final func setupUI() {
//        view.backgroundColor = .white
        setupViewControllers()
        setupTabBar()
    }
    
    final func setupViewControllers() {
        viewControllers = [homeVC, searchVC, profileVC, moreTab]
    }
    
    final func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        tabBar.indicatorColor = .white
        tabBar.barTintColor = UIColor(hexString: "292929")
    }
}

final class NavigationController: UINavigationController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI
    func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(hexString: "0B030F")
        appearance.shadowColor = .clear
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
    }
}
