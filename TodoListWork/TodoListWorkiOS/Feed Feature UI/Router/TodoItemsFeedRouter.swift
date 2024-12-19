//
//  TodoItemsFeedRouter.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import TodoListWork
import UIKit

public final class TodoItemsFeedRouter: TodoItemsFeedRouterNavigator {
    private let navigationController: UINavigationController
    private let todoDetailComposer: (TodoItem) -> UIViewController
    private let addTodoComposer: () -> UIViewController
    private let shareTodoComposer: (TodoItem) -> UIActivityViewController
    
    public init(
        navigationController: UINavigationController,
        todoDetailComposer: @escaping (TodoItem) -> UIViewController,
        addTodoComposer: @escaping () -> UIViewController,
        shareTodoComposer: @escaping (TodoItem) -> UIActivityViewController
    ) {
        self.navigationController = navigationController
        self.todoDetailComposer = todoDetailComposer
        self.addTodoComposer = addTodoComposer
        self.shareTodoComposer = shareTodoComposer
    }
    
    public func navigateToTodoItemDetails(for item: TodoListWork.TodoItem) {
        let todoDetailVC = todoDetailComposer(item)
        navigationController.pushViewController(todoDetailVC, animated: true)
    }
    
    public func addNewTodo() {
        let addTodoVC = addTodoComposer()
        navigationController.pushViewController(addTodoVC, animated: true)
    }
    
    public func shareTodo(for item: TodoListWork.TodoItem) {
        let shareTodoVC = shareTodoComposer(item)
        navigationController.present(shareTodoVC, animated: true)
    }
}
