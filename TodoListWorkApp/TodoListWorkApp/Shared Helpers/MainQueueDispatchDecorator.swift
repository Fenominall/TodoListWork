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

extension MainQueueDispatchDecorator: FeedLoader where T == FeedLoader {
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: ItemSaveable where T == ItemSaveable {
    func save(_ item: TodoListWork.TodoItem, completion: @escaping (ItemSaveable.Result) -> Void) {
        decoratee.save(item) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
    
    func update(_ item: TodoListWork.TodoItem, completion: @escaping (ItemSaveable.Result) -> Void) {
        decoratee.update(item) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: ItemDeleteable where T == ItemDeleteable {
    func delete(_ item: TodoListWork.TodoItem, completion: @escaping (ItemDeleteable.Result) -> Void) {
        decoratee.delete(item) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}


extension MainQueueDispatchDecorator: ItemSearchable where T == ItemSearchable {
    func search(by query: String, completion: @escaping (ItemSearchable.Result) -> Void) {
        decoratee.search(by: query) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
