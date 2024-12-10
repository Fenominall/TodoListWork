//
//  TodoItemsFeedView.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import TodoListWork

public protocol TodoItemsFeedView: AnyObject {
    func displayTasks(_ viewModel: [TodoItem])
}

