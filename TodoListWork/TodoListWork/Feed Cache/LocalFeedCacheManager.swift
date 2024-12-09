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
