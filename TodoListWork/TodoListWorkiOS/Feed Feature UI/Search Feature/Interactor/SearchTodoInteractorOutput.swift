//
//  SearchTodoInteractorOutpu.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/21/24.
//

import TodoListWork

public protocol SearchTodoInteractorOutput: AnyObject {
    func didFinishSearchingTodos(with result: [TodoItem])
    func didFinishSearchingTodos(with error: Error)
}
