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
    public init(store: TodoItemsStore) {
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

// MARK: - Feed Caching
extension LocalFeedCacheManager: TodoItemsFeedCache {
    public func save(
        _ feed: [TodoItem],
        completion: @escaping (TodoItemsFeedCache.Result) -> Void) {
            store.insert(feed.toLocale()) { [weak self] insertionError in
                self?.execute(completion, result: insertionError)
            }
        }
}

// MARK: - Saving and Updaing TodoItem
extension LocalFeedCacheManager: TodoItemSaver {
    public func save(
        _ item: TodoItem,
        completion: @escaping (TodoItemSaver.Result) -> Void) {
            store.insert(convertToLcalTodoItem(item)) { [weak self] insertionError in
                self?.execute(completion, result: insertionError)
            }
        }
    
    public func update(
        _ item: TodoItem,
        completion: @escaping (TodoItemSaver.Result) -> Void) {
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
extension LocalFeedCacheManager: TodoItemDeleter {
    public func delete(
        _ item: TodoItem,
        completion: @escaping (TodoItemDeleter.Result) -> Void) {
            store.delete(convertToLcalTodoItem(item)) { [weak self] deletionError in
                self?.execute(completion, result: deletionError)
            }
    }
}

// MARK: - Converting mapping helpers
private extension Array where Element == LocalTodoItem {
    func toModels() -> [TodoItem] {
        return map {
            TodoItem(
                id: $0.id,
                title: $0.title,
                description: $0.description,
                completed: $0.completed,
                createdAt: $0.createdAt,
                userId: $0.userId
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
                userId: $0.userId
            )
        }
    }
}
