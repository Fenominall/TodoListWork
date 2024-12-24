//
//  Array+ConvertingExtensions.swift
//  TodoListWork
//
//  Created by Fenominall on 12/20/24.
//

import Foundation

// MARK: - Converting mapping helpers
extension Array where Element == LocalTodoItem {
    func toModels() -> [TodoItem] {
        return map {
            TodoItem(
                id: $0.id,
                title: $0.title,
                description: $0.description,
                completed: $0.completed,
                createdAt: $0.createdAt,
                userId: $0.userId
            )
        }
    }
}

extension Array where Element == TodoItem {
    func toLocaleModels() -> [LocalTodoItem] {
        return map {
            LocalTodoItem(
                id: $0.id,
                title: $0.title,
                description: $0.description,
                completed: $0.completed,
                createdAt: $0.createdAt,
                userId: $0.userId
            )
        }
    }
}
