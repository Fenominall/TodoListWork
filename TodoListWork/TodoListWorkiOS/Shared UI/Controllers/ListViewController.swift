//
//  ListViewController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit
import TodoListWork

public final class ListViewController: UIViewController {
    // MARK: - Properties
    public var onRefresh: (() -> Void)?
    public var addNewTodo: (() -> Void)?
    public var onSearch: ((String) -> Void)?
    
    // # Step 1
    // control the state to reload automatically what change, using Int for section and the models for data source
    // The model needs to be hashable
    private lazy var dataSource: UITableViewDiffableDataSource<Int, CellController> = {
        .init(tableView: feedTableView) { (tableView, indexPath, controller) in
            return controller.dataSource.tableView(tableView, cellForRowAt: indexPath)
        }
    }()
    
    private var isTableViewEmpty: Bool = false
    
    private var isFiltering: Bool {
        guard let searchText = searchController.searchBar.text else { return false }
        return searchController.isActive && !searchText.isEmpty
    }
    
    // MARK: - View Properties
    private let errorView = ErrorView()
    private let footerView = TodoListFooterView()
    
    private lazy var feedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let searchIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Results Found!"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()
    
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
        setupUIConstraints()
        configureTableView()
        configureDataSource()
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
        isTableViewEmpty = itemCount == 0
        
        footerView.updateCountLabel(with: itemCount)
        showHideNoResultsLabelBasedOnCount(with: itemCount)
    }
    
    private func setupUI() {
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        // # Step 2 - make UITableView as UITableViewDiffableDataSource
        feedTableView.dataSource = dataSource
        feedTableView.delegate = self
        feedTableView.refreshControl = refreshControll
        // TODO - bug that error view not clickable
        feedTableView.tableHeaderView = errorView.makeContainer()
    }
    
    private func configureDataSource() {
        dataSource.defaultRowAnimation = .fade
    }
    
    private func setupUIConstraints() {
        // Add search indicator and no-results label
        view.addSubview(feedTableView)
        view.addSubview(footerView)
        view.addSubview(searchIndicator)
        view.addSubview(noResultsLabel)
        
        NSLayoutConstraint.activate([
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 83),
            
            feedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            // SearchIndicator
            searchIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // noResultsLabel
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setDelegates() {
        footerView.delegate = self
    }
    
    private func cellController(at indexPath: IndexPath) -> CellController? {
        dataSource.itemIdentifier(for: indexPath)
    }
    
    private func showHideNoResultsLabelBasedOnCount(with items: Int) {
        if isFiltering {
            noResultsLabel.isHidden = items > 0
        }
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(feedTableView, didSelectRowAt: indexPath)
    }
    
    public func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        let dl = cellController(at: indexPath)?.delegate
        dl?.tableView?(feedTableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    public func tableView(
        _ tableView: UITableView,
        didEndDisplaying cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(feedTableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    public func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let delegate = cellController(at: indexPath)?.delegate
        return delegate?.tableView?(feedTableView, contextMenuConfigurationForRowAt: indexPath, point: point)
    }
    
    public func tableView(
        _ tableView: UITableView,
        willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
        animator: (any UIContextMenuInteractionAnimating)?
    ) {
        guard let indexPath = configuration.identifier as? IndexPath else {
            return
        }
        
        // Retrieve the delegate for the cell controller
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(feedTableView, willEndContextMenuInteraction: configuration, animator: animator)
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController {
    private func configureSearchController() {
        definesPresentationContext = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
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
        guard let searchText = searchController.searchBar.text,
              !searchText.isEmpty else { return }
        // TODO
    }
}

// MARK: - UISearchResultsUpdating
extension ListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(),
              !searchText.isEmpty else { return }
        
        onSearch?(searchText)
    }
}

// MARK: - UISearchControllerDelegate
extension ListViewController: UISearchControllerDelegate {
    public func didDismissSearchController(_ searchController: UISearchController) {
        noResultsLabel.isHidden = true
        
        if isTableViewEmpty {
            refresh()
        }
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
        searchIndicator.update(isRefreshing: viewModel.isLoading)
    }
}
