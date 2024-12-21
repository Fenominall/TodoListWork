//
//  SearchTodoInteractorOutpu.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/21/24.
//

import TodoListWork

public protocol SearchTodoInteractorOutput: AnyObject {
    func didFinishSearchingTodo(with result: [TodoItem])
    func didFinishSearchingTodo(with error: Error)
}
