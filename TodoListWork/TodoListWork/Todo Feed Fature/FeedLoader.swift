//
//  FeedLoader.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[TodoItem], Error>
    
    func loadFeed(completion: @escaping (Result) -> Void)
}
