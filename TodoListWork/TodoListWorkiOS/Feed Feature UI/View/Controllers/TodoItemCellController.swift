//
//  TodoItemCellController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import Foundation
import UIKit

public final class TodoItemCellController {
    private typealias TodoItemCellConfigurator = TableCellConfigurator<TodoItemTableViewCell, TodoItemFeedViewModel>
    
    private let cellConfigurator: TodoItemCellConfigurator
    private(set) var viewModel: TodoItemFeedViewModel
    private var cell: TodoItemTableViewCell?
    private let selection: () -> Void
    private(set) var onCompletedStatusToggle: (TodoItemFeedViewModel) -> Void
    
    public init(viewModel: TodoItemFeedViewModel,
                selection: @escaping () -> Void,
                onCompletedStatusToggle: @escaping (TodoItemFeedViewModel) -> Void) {
        self.cellConfigurator = TableCellConfigurator(item: viewModel)
        self.viewModel = viewModel
        self.selection = selection
        self.onCompletedStatusToggle = onCompletedStatusToggle
    }
    
    func registerCell(in tableView: UITableView) {
        cellConfigurator.register(tableView)
    }
    
    func configureCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableCellConfigurator<TodoItemTableViewCell, TodoItemFeedViewModel>.reuseIdentifier,
            for: indexPath
        ) as? TodoItemTableViewCell else {
            return UITableViewCell()
        }
        cellConfigurator.configure(cell: cell)
        
        // Additional Configuration
        cell.checkmarkTappedHandler = { [weak self] isCompleted in
            guard let self = self else { return }
            self.viewModel.isCompleted = isCompleted
            self.onCompletedStatusToggle(self.viewModel)
        }
        
        return cell
    }
}
