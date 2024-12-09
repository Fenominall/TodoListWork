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
    // A utility to safely execute a completion handler, ensuring that it's only called when it's non-nil
    private typealias Completion<T> = (T) -> Void
    
    private func execute<T>(_ completion: Completion<T>?, result: T) {
        guard completion != nil else { return }
        completion?(result)
    }
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
        completion: @escaping (TodoItemsFeedCache.Result) -> Void) {
            store.insert(feed.toLocale()) { [weak self] insertionError in
                self?.execute(completion, result: insertionError)
        }
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

private extension Array where Element == TodoItem {
    func toLocale() -> [LocalTodoItem] {
        return map {
            LocalTodoItem(
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
