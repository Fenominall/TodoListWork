//
//  TodoItemsFeedInteractorOutput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import TodoListWork

// Protocol for handling feed loading output
public protocol TodoItemsFeedLoadingOutput: AnyObject {
    func didStartLoading()
    func didFinishLoading(with items: [TodoItem])
    func didFinishLoading(with error: Error)
}

// Protocol for handling operations like update, delete, etc.
public protocol TodoItemsOperationOutput: AnyObject {
    func didFinishOperation() // Generic for any operation
    func didFinishOperation(with error: Error)
}
