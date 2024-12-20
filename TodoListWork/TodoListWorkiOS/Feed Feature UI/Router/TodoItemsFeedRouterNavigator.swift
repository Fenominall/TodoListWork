//
//  TodoItemsFeedRouterNavigator.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import TodoListWork

public protocol TodoItemsFeedRouterNavigator {
    func navigateToTodoItemDetails(for item: TodoItem)
    func addNewTodo()
    func shareTodo(for item: TodoItem)
}
