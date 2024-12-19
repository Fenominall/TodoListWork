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
    private weak var controller: ListViewController?
    private let selection: (TodoItem) -> Void
    private var onDelete: ((TodoItem) -> Void)?
    private var onUpdate: ((TodoItem) -> Void)?
    private var onShare: (TodoItem) -> Void
    private let currentFeed: [TodoItem: CellController]
    
    init(currentFeed: [TodoItem: CellController] = [:],
         controller: ListViewController,
         selection: @escaping (TodoItem) -> Void,
         onShare: @escaping (TodoItem) -> Void
    ) {
        self.currentFeed = currentFeed
        self.controller = controller
        self.selection = selection
        self.onShare = onShare
    }
    
    func setOnDeleteHandler(_ handler: @escaping (TodoItem) -> Void) {
        self.onDelete = handler
    }
    
    func setOnUpdateHandler(_ handler: @escaping (TodoItem) -> Void) {
        self.onUpdate = handler
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
                share: { [weak self] in
                    guard let self = self else { return }
                    self.onShare(model)
                },
                onCompletedStatusToggle: { [weak self] updatedTask in
                    self?.onUpdate?(updatedTask.toDomainModel())
                }
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

private extension TodoItemFeedViewModel {
    func toDomainModel() -> TodoItem {
        TodoItem(
            id: id,
            title: title,
            description: description,
            completed: isCompleted,
            createdAt: createdAt,
            userId: userId
        )
    }
}
