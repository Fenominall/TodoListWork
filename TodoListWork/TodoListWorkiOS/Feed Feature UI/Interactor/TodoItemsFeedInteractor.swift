//
//  TodoItemsFeedInteractor.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import TodoListWork

public final class TodoItemsFeedInteractor {
    private let feedLoader: TodoItemsFeedLoader
    private let feedSaver: TodoItemsFeedCache
    private let todoUpdater: TodoItemSaver
    private let todoDeleter: TodoItemDeleter
    private weak var presenter: TodoItemsFeedInteractorOutput?
    
    init(
        feedLoader: TodoItemsFeedLoader,
        feedSaver: TodoItemsFeedCache,
        todoUpdater: TodoItemSaver,
        todoDeleter: TodoItemDeleter
    ) {
        self.feedLoader = feedLoader
        self.feedSaver = feedSaver
        self.todoUpdater = todoUpdater
        self.todoDeleter = todoDeleter
    }
}
