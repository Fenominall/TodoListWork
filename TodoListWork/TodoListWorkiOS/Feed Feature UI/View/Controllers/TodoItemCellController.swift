//
//  TodoItemCellController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import Foundation
import UIKit

final class TodoItemCellController {
    private(set) var viewModel: TodoItemFeedViewModel
    private var cell: TodoItemTableViewCell?
    private(set) var onCompletedStatusToggle: (TodoItemFeedViewModel) -> Void
    
    public init(viewModel: TodoItemFeedViewModel,
                onCompletedStatusToggle: @escaping (TodoItemFeedViewModel) -> Void) {
        self.viewModel = viewModel
        self.onCompletedStatusToggle = onCompletedStatusToggle
    }
    
    public func view() -> UITableViewCell {
        if cell == nil {
            cell = binded(TodoItemTableViewCell())
        }
        return cell ?? UITableViewCell()
    }
    
    private func binded(_ cell: TodoItemTableViewCell) -> TodoItemTableViewCell {
        cell.configure(
            todoTitle: viewModel.title,
            todokDescription: viewModel.description ?? "",
            todokDate: dateConvertedToDMYString(date: viewModel.createdAt),
            isCompleted: viewModel.isCompleted,
            todoStatusToogler: { [weak self] isCompleted in
                guard let self = self else { return }
                
                self.viewModel.isCompleted = isCompleted
                self.onCompletedStatusToggle(self.viewModel)
            }
        )
        return cell
    }
}
