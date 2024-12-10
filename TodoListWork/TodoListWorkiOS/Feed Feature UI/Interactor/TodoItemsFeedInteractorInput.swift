//
//  TodoItemsFeedInteractorInput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import TodoListWork

public protocol TodoItemsFeedInteractorInput: AnyObject {
    func loadFeed()
    func deleteTodoItem(_ item: TodoItem)
    func updateTodoItem(_ item: TodoItem)
}
