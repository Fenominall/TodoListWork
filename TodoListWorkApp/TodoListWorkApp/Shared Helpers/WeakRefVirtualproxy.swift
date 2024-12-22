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

extension WeakRefVirtualproxy: ResourceLoadingView where T: ResourceLoadingView {
    func display(_ viewModel: TodoListWorkiOS.ResourceLoadingViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualproxy: ResourceErrorView where T: ResourceErrorView {
    func display(_ viewModel: TodoListWorkiOS.ResourceErrorViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualproxy: AddEditTodoItemViewInput where T: AddEditTodoItemViewInput {
    func updateTodoWith(title: String, date: Date, description: String?) {
        object?.updateTodoWith(title: title, date: date, description: description)
    }    
}
