//
//  TodoItem.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

public struct TodoItem {
    public let id: UUID
    public let title: String
    public let description: String?
    public let completed: Bool
    public let createdAt: Date
    public let userID: Int
    
    public init(
        id: UUID = UUID(),
        title: String,
        description: String?,
        completed: Bool,
        createdAt: Date,
        userID: Int
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.completed = completed
        self.createdAt = createdAt
        self.userID = userID
    }
}
