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

    public init(
        interactor: AddEditTodoItemInteractorInput,
        router: AddEditTodoRouter,
        view: AddEditTodoItemViewInput
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

// MARK: - AddEditTodoItemInteractorOutput
extension AddEditTodoItemPresenter: AddEditTodoItemInteractorOutput {
    public func didSaveTodo() {
        router.routeToTasksFeed()
    }
}
