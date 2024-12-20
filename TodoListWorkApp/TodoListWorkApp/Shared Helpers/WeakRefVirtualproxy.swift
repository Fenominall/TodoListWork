//
//  WeakRefVirtualproxy.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import Foundation
import TodoListWorkiOS

final class WeakRefVirtualproxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualproxy: TodoItemsLoadingView where T: TodoItemsLoadingView {
    func display(_ viewModel: TodoListWorkiOS.TodoItemsLoadingViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualproxy: TodoItemsErrorView where T: TodoItemsErrorView {
    func display(_ viewModel: TodoListWorkiOS.TodoItemsErrorViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualproxy: AddEditTodoItemViewInput where T: AddEditTodoItemViewInput {
    func updateTodoWith(title: String, date: Date, description: String?) {
        object?.updateTodoWith(title: title, date: date, description: description)
    }    
}
