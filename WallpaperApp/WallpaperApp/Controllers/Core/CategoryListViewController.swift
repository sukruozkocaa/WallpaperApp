//
//  CategoryListViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.10.2024.
//

import UIKit

// MARK: - CategoryListViewController
final class CategoryListViewController: ViewController<CategoryListViewModel> {

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
    
    // MARK: - Constants
    private let cellHeight: CGFloat = 300.0
    private let tableViewSeparatorLineHeight: CGFloat = 0.5
    private let router: CategoryListRouterProtocol

    init(viewModel: CategoryListViewModelProtocol = CategoryListViewModel(), router: CategoryListRouterProtocol) {
        self.router = router
        super.init(viewModel: CategoryListViewModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad(from: self)
    }
}

// MARK: - Setup UI
private extension CategoryListViewController {
    final func setupUI() {
        setupViewUI()
        setupTableView()
    }
    
    final func setupViewUI() {
        view.backgroundColor = Theme.Color.backgroundColor
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

// MARK: - UITableViewDataSource
extension CategoryListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categoryListResponseItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.categoryListResponseItems[indexPath.section]
        let cell = tableView.dequeueReusableCell(for: CategoryListTableViewViewCell.self, for: indexPath)
        cell.configure(item: item)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CategoryListViewController: UITableViewDelegate {    
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
        if indexPath.section == viewModel.categoryListResponseItems.count - 2 {
            viewModel.nextPage()
        }
    }
}

// MARK: -
extension CategoryListViewController: CategoryListViewModelOutputProtocol {
    func categoryListViewModelOutputProtocol(reloadData: Any) {
        tableView.reloadData()
    }
    
    func categoryListViewModelOutputProtocol(loadData: CategoryListDataModel?) {
        tableView.reloadData()
    }
    
    func categoryListViewModelOutputProtocol(showProgressView: Bool) {
        showProgressView ? self.showProgressView() : self.hideProgressView()
    }
}

// MARK: -
extension CategoryListViewController: CategoryListTableViewViewCellDelegate {
    func categoryListTableViewViewCell(_ cell: CategoryListTableViewViewCell, _ categoryId: String?, _ categoryName: String) {
        router.navigateToHomeViewController(from: self, with: categoryId, categoryName: categoryName)
    }
    
    func categoryListTableViewViewCell(_ cell: CategoryListTableViewViewCell, _ onTapImageView: UIImageView) {
        router.navigateToImageDetail(from: self, imageView: onTapImageView)
    }
}
