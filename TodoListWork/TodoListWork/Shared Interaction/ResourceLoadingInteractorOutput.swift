//
//  TodoItemsFeedInteractorOutput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//


// Protocol for handling feed loading output
public protocol ResourceLoadingInteractorOutput: AnyObject {
    func didStartLoading()
    func didFinishLoading(with items: [TodoItem])
    func didFinishLoading(with error: Error)
}
