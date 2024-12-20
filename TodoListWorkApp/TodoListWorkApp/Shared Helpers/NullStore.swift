//
//  NullStore.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import Foundation
import TodoListWork

final class NullStore: TodoItemsStore {
    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.success((.none)))
    }
    
    func insert(_ tasks: [TodoListWork.LocalTodoItem], completion: @escaping InsertionCompletion) {
        completion(.success(()))
    }
    
    func insert(_ task: TodoListWork.LocalTodoItem, completion: @escaping InsertionCompletion) {
        completion(.success(()))
    }
    
    func update(_ task: TodoListWork.LocalTodoItem, completion: @escaping UpdatingCompletion) {
        completion(.success(()))
    }
    
    func delete(_ task: TodoListWork.LocalTodoItem, completion: @escaping DeletionCompletion) {
        completion(.success(()))
    }
    
    func search(_ query: String, completion: @escaping SearchingCompletion) {
        completion(.success((.none)))
    }
}
