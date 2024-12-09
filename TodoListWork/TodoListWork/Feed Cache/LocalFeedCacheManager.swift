//
//  LocalFeedCacheManager.swift
//  TodoListWork
//
//  Created by Fenominall on 12/9/24.
//

import Foundation

public final class LocalFeedCacheManager {
    
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
