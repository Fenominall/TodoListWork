//
//  ShareTodoItemViewModel.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/19/24.
//

import Foundation
import TodoListWork

public struct ShareTodoItemViewModel {
    public let title: String
    public let description: String
    public let createdAt: Date
    
    public init(with item: TodoItem) {
        self.title = item.title
        self.description = item.description ?? ""
        self.createdAt = item.createdAt
    }
    
    func shareFormattedContent() -> String {
        "\(title)\n\(description)\n\(dateConvertedToDMYString(date: createdAt))"
    }
}
