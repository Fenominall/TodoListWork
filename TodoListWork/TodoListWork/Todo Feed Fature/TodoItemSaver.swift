//
//  TodoItemSaver.swift
//  TodoListWork
//
//  Created by Fenominall on 12/9/24.
//

import Foundation

public protocol TodoItemSaver {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ item: TodoItem, completion: @escaping (Result) -> Void)
    func update(_ item: TodoItem, completion: @escaping (Result) -> Void)
}
