//
//  TodoItemsFeedInteractorOutput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import TodoListWork

public protocol TodoItemsFeedInteractorOutput: AnyObject {
    func didStartOperation()
    func didLoadTodoItems(_ items: [TodoItem])
    func didSelectAddNewTodoItem()
    func didFinish(with error: Error)
    func didFinishOperation()
}
