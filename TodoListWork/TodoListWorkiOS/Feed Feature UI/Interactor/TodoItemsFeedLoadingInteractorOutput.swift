//
//  TodoItemsFeedInteractorOutput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import TodoListWork

// Protocol for handling feed loading output
public protocol TodoItemsFeedLoadingInteractorOutput: AnyObject {
    func didStartLoading()
    func didFinishLoading(with items: [TodoItem])
    func didFinishLoading(with error: Error)
}
