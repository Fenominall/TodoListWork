//
//  TodoFeedItemsMapper.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

public final class TodoFeedItemsMapper {
    
    private struct Root: Decodable {
        let todos: [RemoteTodoItem]
        
        var feed: [TodoItem] {
            return todos.map { $0.item }
        }
    }
    
    private struct RemoteTodoItem: Decodable {
        let id: Int
        let todo: String
        let completed: Bool
        let userId: Int
        
        var item: TodoItem {
            
            return TodoItem(
                id: id,
                title: todo,
                description: nil,
                completed: completed,
                createdAt: Date(),
                userID: userId
            )
        }
    }
    
    private enum Error: Swift.Error {
        case invalidData
    }
    
    private static let jsonDecoder = JSONDecoder()
    
    public static func map(
        _ data: Data,
        from response: HTTPURLResponse
    ) throws -> [TodoItem] {
        guard response.isOK else {
            throw Error.invalidData
        }
        let root = try jsonDecoder.decode(Root.self, from: data)
        
        return root.feed
    }
}
