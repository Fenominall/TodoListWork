//
//  TodoListViewController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit
import SnapKit

public final class TodoListViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - View Properties
    let footerView = TodoListFooterView()
    private var taskActionsMenu = UIMenu()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        return search
    }()
    
    private let todoosTableView: UITableView = {
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
        setupTodoTaskMenu()
        
        todoosTableView.register(TodoTaskTableViewCell.self, forCellReuseIdentifier: "TodoTaskTableViewCell")
                
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
    }
    
    private func setupTodoTaskMenu() {
        let edit = UIAction(title: "Редатировать", image: AppImages.squareAndPencil.image) { _ in
            
        }
        let share = UIAction(title: "Поделиться", image: AppImages.squareAndArrowUp.image) { _ in
            
        }
        let delete = UIAction(title: "Удалить", image: AppImages.trash.image, attributes: .destructive) { _ in }
        
        taskActionsMenu = UIMenu(title: "", children: [edit, share, delete])
    }
}

// MARK: - Helpers
extension TodoListViewController {
    private func setupUI() {
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    private func setDelegates() {
        todoosTableView.delegate = self
        todoosTableView.dataSource = self
        footerView.delegate = self
    }
    
    private func setupConstraints() {
        view.addSubview(todoosTableView)
        view.addSubview(footerView)
        
        footerView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(83)
        }
        
        todoosTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(footerView.snp.top)
        }
        
        // Bring the footer view to the front
        view.bringSubviewToFront(footerView)
    }
}

// MARK: - UITableViewDataSource
extension TodoListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? TodoTaskTableViewCell else {
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
              let cell = tableView.cellForRow(at: indexPath) as? TodoTaskTableViewCell else {
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

extension TodoListViewController: UISearchBarDelegate {
    public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // TODO
    }
}

// MARK: - UISearchResultsUpdating
extension TodoListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        todoosTableView.reloadData()
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
        // TODO
    }
}
