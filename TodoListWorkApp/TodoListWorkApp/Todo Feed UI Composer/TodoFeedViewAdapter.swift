//
//  TodoFeedViewAdapter.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import UIKit
import TodoListWork
import TodoListWorkiOS

final class TodoFeedViewAdapter: TodoItemsFeedView {
    private weak var cotroller: TodoListViewController?
    private let selection: (TodoItem) -> UIViewController
    private var onDelete: ((TodoItem) -> Void)?
    
    init(
        cotroller: TodoListViewController,
        selection: @escaping (TodoItem) -> UIViewController
    ) {
        self.cotroller = cotroller
        self.selection = selection
    }
    
    func setOnDeleteHandler(_ handler: @escaping (TodoItem) -> Void) {
        self.onDelete = handler
    }
    
    func displayTasks(_ viewModel: [TodoListWork.TodoItem]) {
        cotroller?.tableModel = viewModel.map { model in
            TodoItemCellController(
                viewModel: mapToViewModel(from: model),
                selection: { [weak self] in
                    guard let self = self else { return }
                    _ = self.selection(model)
                },
                deletion: {[weak self] in
                    guard let self = self else { return }
                    self.onDelete?(model)
                },
                onCompletedStatusToggle: { _ in }
            )
        }
    }
    
    private func mapToViewModel(from dto: TodoItem) -> TodoItemFeedViewModel {
        return TodoItemFeedViewModel(
            id: dto.id,
            title: dto.title,
            description: dto.description,
            completed: dto.completed,
            createdAt: dto.createdAt,
            userId: dto.userId
        )
    }
}
