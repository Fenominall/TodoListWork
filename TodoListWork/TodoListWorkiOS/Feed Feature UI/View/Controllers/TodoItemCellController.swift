//
//  TodoItemCellController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import Foundation
import UIKit

public final class TodoItemCellController {
    private(set) var viewModel: TodoItemFeedViewModel
    private var cell: TodoItemTableViewCell?
    private(set) var selection: () -> Void
    private(set) var deletion: () -> Void
    private(set) var onCompletedStatusToggle: (TodoItemFeedViewModel) -> Void
    
    public init(
        viewModel: TodoItemFeedViewModel,
        selection: @escaping () -> Void,
        deletion: @escaping () -> Void,
        onCompletedStatusToggle: @escaping (TodoItemFeedViewModel) -> Void
    ) {
        self.viewModel = viewModel
        self.selection = selection
        self.deletion = deletion
        self.onCompletedStatusToggle = onCompletedStatusToggle
    }
    
    public func view() -> UITableViewCell {
        if cell == nil {
            cell = binded(TodoItemTableViewCell())
        }
        
        return cell ?? UITableViewCell()
    }
    
    private func binded(_ cell: TodoItemTableViewCell) -> TodoItemTableViewCell {
        cell.configure(with: viewModel) { [weak self] isCompleted in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.isCompleted = isCompleted
            strongSelf.onCompletedStatusToggle(strongSelf.viewModel)
        }
        return cell
    }
}
