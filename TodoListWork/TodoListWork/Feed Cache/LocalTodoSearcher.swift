//
//  LocalTodoSearcher.swift
//  TodoListWork
//
//  Created by Fenominall on 12/20/24.
//

import Foundation

public final class LocalTodoSearcher: TodoSearcher {
    private let store: TodoItemsStore
    
    public init(store: TodoItemsStore) {
        self.store = store
    }
    
    public func search(
        by query: String,
        completion: @escaping (TodoSearcher.Result) -> Void
    ) {
        store.search(query) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(.some(searchResults)):
                let feed = searchResults.toModels()
                completion(.success(feed))
            case let .failure(error):
                completion(.failure(error))
            case .success(.none):
                completion(.success([]))
            }
        }
    }
}
