//
//  SearchTodoInteractorOutpu.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/21/24.
//

import TodoListWork

public protocol SearchTodoInteractorOutput: AnyObject {
    func didFinishSearching(with items: [TodoItem])
    func didFinishSearching(with error: Error)
}
