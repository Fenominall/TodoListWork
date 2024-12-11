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
    
    init(
        navigationController: UINavigationController,
        todoDetailComposer: @escaping (TodoItem) -> UIViewController,
        addTodoComposer: @escaping () -> UIViewController
    ) {
        self.navigationController = navigationController
        self.todoDetailComposer = todoDetailComposer
        self.addTodoComposer = addTodoComposer
    }
    
    public func navigateToTodoItemDetails(for item: TodoListWork.TodoItem) {
        let todoDetailVC = todoDetailComposer(item)
        navigationController.pushViewController(todoDetailVC, animated: true)
    }
    
    public func addNewTask() {
        let addTodoVC = addTodoComposer()
        navigationController.pushViewController(addTodoVC, animated: true)
    }
    
    
}
