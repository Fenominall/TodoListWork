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
    private weak var controller: TodoListViewController?
    private let selection: (TodoItem) -> UIViewController
    private var onDelete: ((TodoItem) -> Void)?
    private let currentFeed: [TodoItem: CellController]
    
    init(currentFeed: [TodoItem: CellController] = [:],
        controller: TodoListViewController,
        selection: @escaping (TodoItem) -> UIViewController
    ) {
        self.currentFeed = currentFeed
        self.controller = controller
        self.selection = selection
    }
    
    func setOnDeleteHandler(_ handler: @escaping (TodoItem) -> Void) {
        self.onDelete = handler
    }
    
    func displayTasks(_ viewModel: [TodoListWork.TodoItem]) {
        guard let controller = controller else { return }
        var currentFeed = self.currentFeed
        let feed: [CellController] = viewModel.map { model in
            if let controller = currentFeed[model] {
                return controller
            }
            
            let view = TodoItemCellController(
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
            
            let controller = CellController(id: model, view)
            currentFeed[model] = controller
            return controller
        }
        controller.display(feed)
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
