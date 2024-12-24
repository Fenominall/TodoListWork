//
//  LocalFeedCacheManager.swift
//  TodoListWork
//
//  Created by Fenominall on 12/9/24.
//

import Foundation

public final class LocalFeedCacheManager {
    // MARK: - Properties
    private let store: FeedStore
    
    // MARK: - Lifecycle
    public init(store: FeedStore) {
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

// MARK: - Feed Loading
extension LocalFeedCacheManager: FeedLoader {
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        store.retrieve { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(.some(cachedFeed)):
                let feed = cachedFeed.toModels()
                completion(.success(feed))
            case let .failure(error):
                completion(.failure(error))
            case .success(.none):
                completion(.success([]))
            }
        }
    }
}

// MARK: - Feed Caching
extension LocalFeedCacheManager: FeedCache {
    public func save(
        _ feed: [TodoItem],
        completion: @escaping (FeedCache.Result) -> Void) {
            store.insert(feed.toLocaleModels()) { [weak self] insertionError in
                self?.execute(completion, result: insertionError)
            }
        }
}

// MARK: - Saving and Updaing TodoItem
extension LocalFeedCacheManager: ItemSaveable {
    public func save(
        _ item: TodoItem,
        completion: @escaping (ItemSaveable.Result) -> Void) {
            store.insert(convertToLcalTodoItem(item)) { [weak self] insertionError in
                self?.execute(completion, result: insertionError)
            }
        }
    
    public func update(
        _ item: TodoItem,
        completion: @escaping (ItemSaveable.Result) -> Void) {
            store.update(convertToLcalTodoItem(item)) { [weak self] updationError in
                self?.execute(completion, result: updationError)
            }
        }
    
    private func convertToLcalTodoItem(_ item: TodoItem) -> LocalTodoItem {
        LocalTodoItem(
            id: item.id,
            title: item.title,
            description: item.description,
            completed: item.completed,
            createdAt: item.createdAt,
            userId: item.userId
        )
    }
}

// MARK: - Deleting Todoitem
extension LocalFeedCacheManager: ItemDeleteable {
    public func delete(
        _ item: TodoItem,
        completion: @escaping (ItemDeleteable.Result) -> Void) {
            store.delete(convertToLcalTodoItem(item)) { [weak self] deletionError in
                self?.execute(completion, result: deletionError)
            }
    }
}
