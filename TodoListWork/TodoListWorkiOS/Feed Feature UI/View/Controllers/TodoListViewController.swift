//
//  TodoListViewController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit

public final class TodoListViewController: UIViewController {
    // MARK: - Properties
    public var onRefresh: (() -> Void)?
    public var addNewTodo: (() -> Void)?
    
    // # Step 1
    // control the state to reload automatically what change, using Int for section and the models for data source
    // The model needs to be hashable
    private lazy var dataSource: UITableViewDiffableDataSource<Int, CellController> = {
        .init(tableView: todoosTableView) { (tableView, indexPath, controller) in
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
    
    private lazy var todoosTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setDelegates()
        setupConstraints()
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
extension TodoListViewController {
    
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
        // data source will ceck what change using the hashable implementation and only updates what is necessary
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
    
    private func setDelegates() {
        dataSource.defaultRowAnimation = .fade
        // # Step 2 - make UITableView as UITableViewDiffableDataSource
        todoosTableView.dataSource = dataSource
        todoosTableView.delegate = self
        footerView.delegate = self
        todoosTableView.refreshControl = refreshControll
    }
    
    private func setupConstraints() {
        view.addSubview(todoosTableView)
        view.addSubview(errorView)
        view.addSubview(footerView)
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 83),
            
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            todoosTableView.topAnchor.constraint(equalTo: view.topAnchor),
            todoosTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoosTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoosTableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
        ])
        // Bring the footer view to the front
        view.bringSubviewToFront(footerView)
    }
    
    private func cellController(at indexPath: IndexPath) -> CellController? {
        dataSource.itemIdentifier(for: indexPath)
    }
}

// MARK: - UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(todoosTableView, didSelectRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let dl = cellController(at: indexPath)?.delegate
        dl?.tableView?(todoosTableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(todoosTableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let delegate = cellController(at: indexPath)?.delegate
        return delegate?.tableView?(todoosTableView, contextMenuConfigurationForRowAt: indexPath, point: point)
    }
    
    public func tableView(_ tableView: UITableView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: (any UIContextMenuInteractionAnimating)?) {
        guard let indexPath = configuration.identifier as? IndexPath else {
            return
        }
        
        // Retrieve the delegate for the cell controller
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(todoosTableView, willEndContextMenuInteraction: configuration, animator: animator)
    }
}

// MARK: - UISearchBarDelegate
extension TodoListViewController {
    private func configureSearchController() {
        definesPresentationContext = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
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
extension TodoListViewController: UISearchBarDelegate {
    public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // TODO
    }
}

// MARK: - UISearchResultsUpdating
extension TodoListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}

// MARK: - UISearchControllerDelegate
extension TodoListViewController: UISearchControllerDelegate {
    public func didPresentSearchController(_ searchController: UISearchController) {
        // TODO
    }
    
    public func didDismissSearchController(_ searchController: UISearchController) {
        // TODO
    }
}

// MARK: - TodoListFooterViewDelegate
extension TodoListViewController: TodoListFooterViewDelegate {
    func didTapAddNewTaskButton() {
        addNewTodo?()
    }
}

// MARK: - TodoItemsErrorView
extension TodoListViewController: TodoItemsErrorView {
    public func display(_ viewModel: TodoItemsErrorViewModel) {
        errorView.message = viewModel.message
    }
}

// MARK: - TodoItemsLoadingView
extension TodoListViewController: TodoItemsLoadingView {
    public func display(_ viewModel: TodoItemsLoadingViewModel) {
        refreshControll.update(isRefreshing: viewModel.isLoading)
    }
}
