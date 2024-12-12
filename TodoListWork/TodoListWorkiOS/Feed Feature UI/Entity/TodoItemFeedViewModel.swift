//
//  TodoItemViewModel.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import Foundation

public struct TodoItemFeedViewModel {
    public let id: UUID
    public let title: String
    public let description: String?
    public var isCompleted: Bool
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
        self.isCompleted = completed
        self.createdAt = createdAt
        self.userId = userId
    }
}
