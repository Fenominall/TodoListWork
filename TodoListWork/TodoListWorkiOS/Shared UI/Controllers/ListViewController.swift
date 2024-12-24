//
//  ListViewController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit
import TodoListWork

public final class ListViewController: UITableViewController {
    // MARK: - Properties
    public var onRefresh: (() -> Void)?
    public var addNewTodo: (() -> Void)?
    public var onSearch: ((String) -> Void)?
    
    // # Step 1
    // control the state to reload automatically what change, using Int for section and the models for data source
    // The model needs to be hashable
    private lazy var dataSource: UITableViewDiffableDataSource<Int, CellController> = {
        .init(tableView: tableView) { (tableView, indexPath, controller) in
            return controller.dataSource.tableView(tableView, cellForRowAt: indexPath)
        }
    }()
    
    // MARK: - View Properties
    private let errorView = ErrorView()
    private let footerView = TodoListFooterView()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        return search
    }()
    
    private lazy var refreshControll: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureTableView()
        setDelegates()
        configureSearchController()
        refresh()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    // MARK: - Actions
    @objc private func refresh() {
        onRefresh?()
    }
}

// MARK: - Helpers
extension ListViewController {
    
    // # Step 3
    // every time new controllers arrive
    // Using ... dots to support multiple sections if needed
    public func display(_ sections: [CellController]...) {
        // a new empty snapshot created
        var snapshot = NSDiffableDataSourceSnapshot<Int, CellController>()
        // new controllers appended
        sections.enumerated().forEach { section, cellControllers in
            snapshot.appendSections([section])
            snapshot.appendItems(cellControllers, toSection: section)
        }
        // data source will check what change using the hashable implementation and only updates what is necessary
        dataSource.applySnapshotUsingReloadData(snapshot)
        
        // Update the footer view count label
        let itemCount = sections.flatMap { $0 }.count
        footerView.updateCountLabel(with: itemCount)
    }
    
    private func setupUI() {
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        dataSource.defaultRowAnimation = .fade
        // # Step 2 - make UITableView as UITableViewDiffableDataSource
        tableView.dataSource = dataSource
        tableView.refreshControl = refreshControll
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.tableHeaderView = errorView.makeContainer()
        tableView.tableFooterView = footerView.makeContainer()
    }
    
    private func setDelegates() {
        footerView.delegate = self
    }
    
    private func cellController(at indexPath: IndexPath) -> CellController? {
        dataSource.itemIdentifier(for: indexPath)
    }
}

// MARK: - UITableViewDelegate
extension ListViewController {
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let dl = cellController(at: indexPath)?.delegate
        dl?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let delegate = cellController(at: indexPath)?.delegate
        return delegate?.tableView?(tableView, contextMenuConfigurationForRowAt: indexPath, point: point)
    }
    
    public override func tableView(_ tableView: UITableView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: (any UIContextMenuInteractionAnimating)?) {
        guard let indexPath = configuration.identifier as? IndexPath else {
            return
        }
        
        // Retrieve the delegate for the cell controller
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(tableView, willEndContextMenuInteraction: configuration, animator: animator)
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController {
    private func configureSearchController() {
        definesPresentationContext = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        // Used for searchBarBookmarkButtonClicked method
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.showsBookmarkButton = true
        
        searchController.searchBar
            .setImage(
                AppImages.microphoneFill.image,
                for: .bookmark,
                state: .normal
            )
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
//        if searchController.isActive && !searchController.searchBar.text?.isEmpty {
        guard let searchText = searchController.searchBar.text,
              !searchText.isEmpty else { return }
        // TODO
    }
}

// MARK: - UISearchResultsUpdating
extension ListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        
        // TODO
    }
}

// MARK: - UISearchControllerDelegate
extension ListViewController: UISearchControllerDelegate {
    public func didPresentSearchController(_ searchController: UISearchController) {
        // TODO
    }
    
    public func didDismissSearchController(_ searchController: UISearchController) {
        // TODO
    }
}

// MARK: - TodoListFooterViewDelegate
extension ListViewController: TodoListFooterViewDelegate {
    func didTapAddNewTaskButton() {
        addNewTodo?()
    }
}

// MARK: - ResourceErrorView
extension ListViewController: ResourceErrorView {
    public func display(_ viewModel: ResourceErrorViewModel) {
        errorView.message = viewModel.message
    }
}

// MARK: - ResourceLoadingView
extension ListViewController: ResourceLoadingView {
    public func display(_ viewModel: ResourceLoadingViewModel) {
        refreshControll.update(isRefreshing: viewModel.isLoading)
    }
}
