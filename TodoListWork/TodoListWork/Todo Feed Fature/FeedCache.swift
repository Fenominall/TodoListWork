//
//  TodoItemsFeedCache.swift
//  TodoListWork
//
//  Created by Fenominall on 12/9/24.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ feed: [TodoItem], completion: @escaping (Result) -> Void)
}
