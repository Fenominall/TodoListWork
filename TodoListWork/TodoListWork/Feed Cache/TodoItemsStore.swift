//
//  TodoItemsStore.swift
//  TodoListWork
//
//  Created by Fenominall on 12/9/24.
//

import Foundation


public protocol TodoItemsStore {
    typealias DeletionResult = Swift.Result<Void, Error>
    typealias DeletionCompletion = (DeletionResult) -> Void
    
    typealias InsertionResult = Swift.Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
    typealias RetrievalResult = Result<[LocalTodoItem]?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void
    
    typealias UpdatingResult = Swift.Result<Void, Error>
    typealias UpdatingCompletion = (UpdatingResult) -> Void
    
    typealias SearchingResult = Swift.Result<[LocalTodoItem]?, Error>
    typealias SearchingCompletion = (SearchingResult) -> Void
    
    func retrieve(completion: @escaping RetrievalCompletion)
    func insert(_ tasks: [LocalTodoItem], completion: @escaping InsertionCompletion)
    func insert(_ task: LocalTodoItem, completion: @escaping InsertionCompletion)
    func update(_ task: LocalTodoItem, completion: @escaping UpdatingCompletion)
    func delete(_ task: LocalTodoItem, completion: @escaping DeletionCompletion)
    func search(_ query: String, completion: @escaping SearchingCompletion)
}
