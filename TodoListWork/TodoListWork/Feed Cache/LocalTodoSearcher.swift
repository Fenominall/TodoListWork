//
//  LocalTodoSearcher.swift
//  TodoListWork
//
//  Created by Fenominall on 12/20/24.
//

import Foundation

public final class LocalTodoSearcher: TodoSearcher {
    private let store: TodoItemsStore
    
    init(store: TodoItemsStore) {
        self.store = store
    }
    
    public func search(
        by query: String,
        completion: @escaping (TodoSearcher.Result) -> Void
    ) {
        
    }
}
