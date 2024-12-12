//
//  TodoListViewController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit

public final class TodoListViewController: UIViewController {
    // MARK: - Properties
    public var tableModel = [TodoItemCellController]() {
        didSet {
            todoosTableView.reloadData()
            updateCountDisplay()
        }
    }
    public var onRefresh: (() -> Void)?
    public var addNewTodo: (() -> Void)?
    
    // MARK: - View Properties
    let footerView = TodoListFooterView()
    private var taskActionsMenu = UIMenu()
    
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
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: TodoItemTableViewCell.reuseIdentifier)
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
        setupTodoTaskMenu()
        refresh()
    }
    
    // MARK: - Actions
    @objc private func refresh() {
        onRefresh?()
    }
}

// MARK: - Helpers
extension TodoListViewController {
    private func updateCountDisplay() {
        footerView.updateCountLabel(with: tableModel.count)
    }
    private func setupUI() {
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    private func setDelegates() {
        todoosTableView.delegate = self
        todoosTableView.dataSource = self
        footerView.delegate = self
        todoosTableView.refreshControl = refreshControll
    }
    
    private func setupConstraints() {
        view.addSubview(todoosTableView)
        view.addSubview(footerView)
        
        NSLayoutConstraint.activate([
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 83),
            
            todoosTableView.topAnchor.constraint(equalTo: view.topAnchor),
            todoosTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoosTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoosTableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
        ])
        // Bring the footer view to the front
        view.bringSubviewToFront(footerView)
    }
    
    private func setupTodoTaskMenu() {
        let edit = UIAction(title: "Редатировать", image: AppImages.squareAndPencil.image) { _ in
            
        }
        let share = UIAction(title: "Поделиться", image: AppImages.squareAndArrowUp.image) { _ in
            
        }
        let delete = UIAction(title: "Удалить", image: AppImages.trash.image, attributes: .destructive) { _ in }
        
        taskActionsMenu = UIMenu(title: "", children: [edit, share, delete])
    }
    
    private func cellController(for indexPath: IndexPath) -> TodoItemCellController {
        return tableModel[indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension TodoListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(for: indexPath).view()
    }
}

// MARK: - UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? TodoItemTableViewCell else {
            return nil
        }
        
        // Hide the checkmark button when the menu is active
        UIView.animate(withDuration: 0.2) {
            cell.isMenuActive = true
        }
        
        return UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, previewProvider: nil) { _ in
            self.taskActionsMenu
        }
    }
    
    public func tableView(_ tableView: UITableView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: (any UIContextMenuInteractionAnimating)?) {
        guard let indexPath = configuration.identifier as? IndexPath,
              let cell = tableView.cellForRow(at: indexPath) as? TodoItemTableViewCell else {
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            cell.isMenuActive = false
        }
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
        // TODO
    }
}

// MARK: - TodoItemsLoadingView
extension TodoListViewController: TodoItemsLoadingView {
    public func display(_ viewModel: TodoItemsLoadingViewModel) {
        refreshControll.update(isRefreshing: viewModel.isLoading)
    }
}
