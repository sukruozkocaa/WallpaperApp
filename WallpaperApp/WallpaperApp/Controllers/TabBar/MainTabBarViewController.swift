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
        let vm = CategoryListViewModel(apiCaller: APICaller())
        let homeNavTab = NavigationController(rootViewController: CategoryListViewController(viewModel: vm, router: CategoryListRouter()))
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()
    
    private lazy var searchVC: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Search", image: UIImage(named: "ic_magnifyingGlassV2"), selectedImage: nil)
        let viewModel = SearchViewModel()
        let homeNavTab = NavigationController(rootViewController: SearchViewController(viewModel: viewModel))
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()
    
    private lazy var profileVC: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Profile", image: UIImage(named: "ic_man"), selectedImage: nil)
        let vm = CategoryListViewModel(apiCaller: APICaller())
        let homeNavTab = NavigationController(rootViewController: CategoryListViewController(
            viewModel: vm, 
            router: CategoryListRouter())
        )
        homeNavTab.tabBarItem = homeTabItem
        
        return homeNavTab
    }()
    
    lazy var moreTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "More", image: UIImage(named: "ic_wheel"), selectedImage: nil)
        let vm = CategoryListViewModel(apiCaller: APICaller())
        let navController = NavigationController(rootViewController: CategoryListViewController(
            viewModel: vm,
            router: CategoryListRouter())
        )
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
