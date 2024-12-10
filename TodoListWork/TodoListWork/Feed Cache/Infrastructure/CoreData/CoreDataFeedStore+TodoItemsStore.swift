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
        
    }
    
    public func insert(_ tasks: [LocalTodoItem], completion: @escaping InsertionCompletion) {
        
    }
    
    public func insert(_ task: LocalTodoItem, completion: @escaping InsertionCompletion) {
        
    }
    
    public func update(_ task: LocalTodoItem, completion: @escaping UpdatingCompletion) {
        
    }
    
    public func delete(_ task: LocalTodoItem, completion: @escaping DeletionCompletion) {
        
    }
}
