//
//  CoreDataStore+FeedStore.swift
//  TodoListWork
//
//  Created by Fenominall on 12/10/24.
//

import Foundation
import CoreData

extension CoreDataFeedStore: FeedStore {
    public func retrieve(completion: @escaping RetrievalCompletion) {
        performAsync { context in
            completion(Result {
                try ManagedCache.find(in: context).map {
                    return $0.localeTodoFeed
                }
            })
        }
    }
    
    public func insert(
        _ tasks: [LocalTodoItem],
        completion: @escaping InsertionCompletion
    ) {
        performAsync { context in
            completion(Result {
                try ManagedCache.insert(tasks, in: context)
            })
        }
    }
    
    public func insert(
        _ task: LocalTodoItem,
        completion: @escaping InsertionCompletion
    ) {
        insert([task], completion: completion)
    }
    
    public func update(
        _ task: LocalTodoItem,
        completion: @escaping UpdatingCompletion
    ) {
        performAsync { context in
            completion(Result {
                try ManagedCache.update(task, context: context)
            })
        }
    }
    
    public func delete(
        _ task: LocalTodoItem,
        completion: @escaping DeletionCompletion
    ) {
        performAsync { context in
            completion(Result {
                try ManagedTodoItem.delete(task, in: context)
            })
        }
    }
    
    public func search(
        by query: String,
        completion: @escaping SearchingCompletion
    ) {
        performAsync { context in
            completion(Result {
                try ManagedTodoItem
                    .findBy(query, in: context)
                    .compactMap { return $0.local }
            })
        }
    }
}
