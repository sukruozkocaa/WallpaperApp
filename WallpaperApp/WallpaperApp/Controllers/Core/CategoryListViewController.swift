//
//  CategoryListViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 28.08.2024.
//

import UIKit

// MARK: - CategoryListViewController
final class CategoryListViewController: BaseViewController {

    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
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
    private var viewModel: CategoryViewModelProtocol
    private let router: CategoryListRouterProtocol
    var storedOffsets = [Int: CGFloat]()

    // MARK: - Constants
    private let cellHeight: CGFloat = 300.0
    private let tableViewSeparatorLineHeight: CGFloat = 0.5
    
    // MARK: - Life Cycles
    init(viewModel: CategoryViewModelProtocol = CategoryViewModel(), router: CategoryListRouterProtocol = CategoryListRouter()) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.loadCategoryList()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: - Bind ViewModel
private extension CategoryListViewController {
    final func bindViewModel() {
        viewModel.reloadHandler = { [weak self] in
            guard let self else { return }
            tableView.reloadData()
        }
    }
}

// MARK: - Setup Views
private extension CategoryListViewController {
    final func setupViews() {
        view.backgroundColor = Theme.Color.backgroundColor
        setupTableView()
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
        return viewModel.categoryList.value?.collections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.categoryList.value?.collections?[indexPath.section] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(for: CategoryListTableViewViewCell.self, for: indexPath)
        cell.configure(item: item)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != .zero else { return nil }
        let separatorLineView = UIView(frame: CGRect(
            x: .zero,
            y: .zero,
            width: tableView.frame.width,
            height: tableViewSeparatorLineHeight)
        )
        separatorLineView.backgroundColor = Theme.Color.tableViewSeparatorLineColor
        return separatorLineView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section != .zero else { return CGFloat() }
        return tableViewSeparatorLineHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let collectionsCount = viewModel.categoryList.value?.collections?.count,
                 indexPath.section == collectionsCount - 2 else { return }

        viewModel.loadCategoryList()
    }
}

// MARK: - CategoryListTableViewViewCellDelegate
extension CategoryListViewController: CategoryListTableViewViewCellDelegate {
    func categoryListTableViewViewCell(_ cell: CategoryListTableViewViewCell, _ categoryId: String?) {
        router.navigateToHomeViewController(from: self, with: categoryId, categoryName: nil)
    }
    
    func categoryListTableViewViewCell(_ cell: CategoryListTableViewViewCell, _ onTapImageView: UIImageView) {
        router.navigateToImageDetail(from: self, imageView: onTapImageView)
    }
    
    func categoryListTableViewViewCell(_ cell: CategoryListTableViewViewCell, _ categoryId: String?, _ categoryName: String) {
        router.navigateToHomeViewController(from: self, with: categoryId, categoryName: categoryName)
    }
}
