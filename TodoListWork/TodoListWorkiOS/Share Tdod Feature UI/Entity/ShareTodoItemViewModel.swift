//
//  ShareTodoItemViewModel.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/19/24.
//

import Foundation

public struct ShareTodoItemViewModel {
    public let title: String
    public let description: String
    public let createdAt: Date
    
    public init(
        title: String,
        description: String,
        createdAt: Date
    ) {
        self.title = title
        self.description = description
        self.createdAt = createdAt
    }
}
