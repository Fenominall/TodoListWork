//
//  TodoItemDeleter.swift
//  TodoListWork
//
//  Created by Fenominall on 12/9/24.
//

import Foundation

public protocol ItemDeleteable {
    typealias Result = Swift.Result<Void, Error>
    
    func delete(_ item: TodoItem, completion: @escaping (Result) -> Void)
}
