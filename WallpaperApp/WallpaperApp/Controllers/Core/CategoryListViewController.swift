//
//  CategoryListViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 28.08.2024.
//

import UIKit

// MARK: - CategoryListViewController
final class CategoryListViewController: UIViewController {

    // MARK: - Views
    private lazy var navBarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_appNavBar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg_NeonLight")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.rowHeight = cellHeight
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cell: CategoryListTableViewViewCell.self)
        return tableView
    }()

    // MARK: - Variables
    var model: CategoryViewModel = CategoryViewModel()
    var storedOffsets = [Int: CGFloat]()

    // MARK: - Constants
    private let cellHeight: CGFloat = 300.0
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        callToViewModelForUIUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarView()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navBarImageView.removeFromSuperview()
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: - Setup ViewModel
private extension CategoryListViewController {
    final func callToViewModelForUIUpdate() {
        model.getCategoryList()
        model.reloadHandler = { [weak self] in
            guard let self = self else { return }
            tableView.reloadData()
        }
    }
}

// MARK: - Navigation Bar
private extension CategoryListViewController {
    final func setupNavigationBarView() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationItem.titleView = navBarImageView
    }
}

// MARK: - Setup Views
private extension CategoryListViewController {
    final func setupViews() {
        view.backgroundColor = Theme.Color.backgroundColor
        setupBackgroundImageView()
        setupTableView()
    }
    
    final func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }

    final func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.categoryList.value?.collections?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model.categoryList.value?.collections?[indexPath.section] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(for: CategoryListTableViewViewCell.self, for: indexPath)
        cell.configure(categoryId: item.id, title: item.title, data: item.photoList)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 5.0))
        view.backgroundColor = UIColor(hexString: "0B030F")
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
}

// MARK: - Routers
private extension CategoryListViewController {
    final func pushToHomeViewController(categoryType: CategoryTypes) {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
    final func pushToImageDetailVC(image: UIImage?, view: UIView) {
        let imageDetailVC = ImageDetailViewController(image: image)
        imageDetailVC.setZoomTransition(originalView: view)
        self.present(imageDetailVC, animated: true)
    }
    
    final func pushToHomeViewController(type: CategoryTypes) {
        pushToHomeViewController(categoryType: type)
    }
}

// MARK: - CategoryListTableViewViewCellDelegate
extension CategoryListViewController: CategoryListTableViewViewCellDelegate {
    func categoryListTableViewViewCell(_ cell: CategoryListTableViewViewCell, _ categoryId: String?) {
        let homeVC = HomeViewController()
        homeVC.categoryId = categoryId
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func categoryListTableViewViewCell(_ cell: CategoryListTableViewViewCell, _ onTapImageView: UIImageView) {
        pushToImageDetailVC(image: onTapImageView.image, view: onTapImageView)
    }
    
    func categoryListTableViewViewCell(_ cell: CategoryListTableViewViewCell, _ categoryId: String?, _ categoryName: String) {
        let homeVC = HomeViewController()
        homeVC.categoryId = categoryId
        homeVC.navigationItem.title = categoryName
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
