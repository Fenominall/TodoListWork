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
                
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
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
}

// MARK: - TodoListFooterViewDelegate
extension TodoListViewController: TodoListFooterViewDelegate {
    func didTapAddNewTaskButton() {
        // TODO
    }
}
