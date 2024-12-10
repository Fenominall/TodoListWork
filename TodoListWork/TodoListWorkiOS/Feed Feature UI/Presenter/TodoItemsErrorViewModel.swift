//
//  TodoItemsErrorViewModel.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import Foundation

public struct TodoItemsErrorViewModel {
    public let message: String?
    
    static var noError: TodoItemsErrorViewModel {
        return TodoItemsErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> TodoItemsErrorViewModel {
        return TodoItemsErrorViewModel(message: message)
    }
}
