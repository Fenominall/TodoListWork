//
//  MainQueueDispatchDecorator.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import Foundation
import TodoListWork
// Utility for ensuring that operations targeting the main thread are executed safely and correctly it can help to prevent race conditions and crashes that may occur from executing UI-related code on background threads.
final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void){
        guard Thread.isMainThread else {
            return DispatchQueue.main.asyncAndWait(execute: completion)
        }
        completion()
    }
}

extension MainQueueDispatchDecorator: TodoItemsFeedLoader where T == TodoItemsFeedLoader {
    func loadFeed(completion: @escaping (TodoItemsFeedLoader.Result) -> Void) {
        decoratee.loadFeed { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: TodoItemSaver where T == TodoItemSaver {
    func save(_ item: TodoListWork.TodoItem, completion: @escaping (TodoItemSaver.Result) -> Void) {
        decoratee.save(item) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
    
    func update(_ item: TodoListWork.TodoItem, completion: @escaping (TodoItemSaver.Result) -> Void) {
        decoratee.update(item) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: TodoItemDeleter where T == TodoItemDeleter {
    func delete(_ item: TodoListWork.TodoItem, completion: @escaping (TodoItemDeleter.Result) -> Void) {
        decoratee.delete(item) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
