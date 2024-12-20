//
//  TodoFeedItemsMapper.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

public final class TodoFeedItemsMapper {
    
    // MARK: - Nested Types
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
                id: uuidFromID(id),
                title: todo,
                description: nil,
                completed: completed,
                createdAt: Date(),
                userId: userId
            )
        }
        
        private func uuidFromID(_ id: Int) -> UUID {
            let uuidString = String(format: "%08x-0000-0000-0000-000000000000", id)
            return UUID(uuidString: uuidString) ?? UUID()
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
