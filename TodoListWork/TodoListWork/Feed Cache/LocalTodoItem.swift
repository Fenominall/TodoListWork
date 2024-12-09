//
//  LocalTodoItem.swift
//  TodoListWork
//
//  Created by Fenominall on 12/9/24.
//

import Foundation

public struct LocalTodoItem {
    public let id: UUID
    public let title: String
    public let description: String?
    public let completed: Bool
    public let createdAt: Date
    public let userId: Int
    
    public init(
        id: UUID,
        title: String,
        description: String?,
        completed: Bool,
        createdAt: Date,
        userId: Int
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.completed = completed
        self.createdAt = createdAt
        self.userId = userId
    }
}
