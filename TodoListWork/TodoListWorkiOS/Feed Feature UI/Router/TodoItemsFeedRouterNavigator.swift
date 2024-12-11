//
//  TodoItemsFeedRouterNavigator.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import TodoListWork

public protocol TodoItemFeedRouterNavigator {
    func navigateToTodoItemDetails(for item: TodoItem)
    func addNewTask()
}
