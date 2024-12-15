//
//  AddEditTodoItemPresenter.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/13/24.
//

import Foundation
import TodoListWork

public final class AddEditTodoItemPresenter {
    private let interactor: AddEditTodoItemInteractorInput
    private let router: AddEditTodoRouter
    private let view: AddEditTodoItemViewInput
    
    private let todoToEdit: TodoItem?
    private var currentTitle: String
    private var currentDate: Date
    private var currentDescription: String?

    public init(
        interactor: AddEditTodoItemInteractorInput,
        router: AddEditTodoRouter,
        view: AddEditTodoItemViewInput,
        todoToEdit: TodoItem?
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.todoToEdit = todoToEdit
        self.currentTitle = todoToEdit?.title ?? ""
        self.currentDate = todoToEdit?.createdAt ?? Date()
        self.currentDescription = todoToEdit?.description
    }
}

// MARK: - AddEditTodoItemInteractorOutput
extension AddEditTodoItemPresenter: AddEditTodoItemInteractorOutput {
    public func didSaveTodo() {
        router.routeToTasksFeed()
    }
}
