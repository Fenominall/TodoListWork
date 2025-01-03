//
//  LocalTodoSearcher.swift
//  TodoListWork
//
//  Created by Fenominall on 12/20/24.
//

import Foundation

public final class LocalTodoSearcher: ItemSearchable {
    private let store: FeedStore
    
    public init(store: FeedStore) {
        self.store = store
    }
    
    public func search(
        by query: String,
        completion: @escaping (ItemSearchable.Result) -> Void
    ) {
        store.search(by: query) { [weak self] result in
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
