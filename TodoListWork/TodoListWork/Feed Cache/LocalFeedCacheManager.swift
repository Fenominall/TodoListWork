//
//  LocalFeedCacheManager.swift
//  TodoListWork
//
//  Created by Fenominall on 12/9/24.
//

import Foundation

public final class LocalFeedCacheManager {
    // MARK: - Properties
    private let store: TodoItemsStore
    
    // MARK: - Lifecycle
    init(store: TodoItemsStore) {
        self.store = store
    }
    
    // MARK: - Helpers
}

extension LocalFeedCacheManager: TodoItemsFeedLoader {
    public func loadFeed(completion: @escaping (TodoItemsFeedLoader.Result) -> Void) {
        store.retrieve { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(.some(cachedFeed)):
                let feed = cachedFeed.toModels()
                completion(.success(feed))
            case let .failure(error):
                completion(.failure(error))
            case .success(.none):
                break
            }
        }
    }
}

extension LocalFeedCacheManager: TodoItemsFeedCache {
    public func save(
        _ feed: [TodoItem],
        completion: @escaping (TodoItemsFeedCache.Result) -> Void
        
    ) {
    }
}

extension LocalFeedCacheManager: TodoItemSaver {
    public func save(
        _ item: TodoItem,
        completion: @escaping (TodoItemSaver.Result) -> Void
    ) {
    
    }
    
    public func update(
        _ item: TodoItem,
        completion: @escaping (TodoItemSaver.Result) -> Void
    ) {
        
    }
}

extension LocalFeedCacheManager: TodoItemDeleter {
    public func delete(
        _ item: TodoItem,
        completion: @escaping (TodoItemDeleter.Result) -> Void
    ) {
        
    }
}

private extension Array where Element == LocalTodoItem {
    func toModels() -> [TodoItem] {
        return map {
            TodoItem(
                id: $0.id,
                title: $0.title,
                description: $0.description,
                completed: $0.completed,
                createdAt: $0.createdAt,
                userID: $0.userID
            )
        }
    }
}
