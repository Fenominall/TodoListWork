//
//  TodoItemsFeedView.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

public protocol ResourceView: AnyObject {
    func display(_ viewModel: [TodoItem])
}

