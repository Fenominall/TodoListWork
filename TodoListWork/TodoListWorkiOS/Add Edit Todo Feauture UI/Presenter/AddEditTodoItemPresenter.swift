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
    
    public init(
        interactor: AddEditTodoItemInteractorInput,
        router: AddEditTodoRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
}

extension AddEditTodoItemPresenter: AddEditTodoItemInteractorOutput {
    public func didSaveTodo() {
        router.routeToTasksFeed()
    }
    
    public func didUpdateTodo() {
        router.routeToTasksFeed()
    }
}
