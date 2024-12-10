//
//  CoreDataStore+FeedStore.swift
//  TodoListWork
//
//  Created by Fenominall on 12/10/24.
//

import Foundation
import CoreData

extension CoreDataFeedStore: TodoItemsStore {
    public func retrieve(completion: @escaping RetrievalCompletion) {
        performAsync { context in
            completion(Result {
                try ManagedCache.find(in: context).map {
                    return $0.localTodoTasksFeed
                }
            })
        }
    }
    
    public func insert(_ tasks: [LocalTodoItem], completion: @escaping InsertionCompletion) {
        performAsync { context in
            completion(Result {
                try ManagedCache.insertTasks(tasks, in: context)
            })
        }
    }
    
    public func insert(_ task: LocalTodoItem, completion: @escaping InsertionCompletion) {
        insert([task], completion: completion)
    }
    
    public func update(_ task: LocalTodoItem, completion: @escaping UpdatingCompletion) {
        performAsync { context in
            completion(Result {
                try ManagedCache.updateTask(task, context: context)
            })
        }
    }
    
    public func delete(_ task: LocalTodoItem, completion: @escaping DeletionCompletion) {
        performAsync { context in
            completion(Result {
                try ManagedTodoItem.deleteTask(task, in: context)
            })
        }

    }
}
