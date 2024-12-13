//
//  AddEditTodoItemViewModel.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/13/24.
//

import Foundation
import TodoListWork

public final class  AddEditTodoItemViewModel {
    // MARK: - Properties
    private var todoToEdit: TodoItem?
    public var onSaveAddTodo: ((TodoItem) -> Void)?
    public var onSaveUpdateTodo: ((TodoItem) -> Void)?
    
    private let title: String
    private let description: String?
    private let createdAt: Date
    
    // MARK: - Lifecycle
    public init(todoToEdit: TodoItem? = nil) {
        if let editTodo = todoToEdit {
            self.title = editTodo.title
            self.description = editTodo.description
            self.createdAt = editTodo.createdAt
        } else {
            self.title = ""
            self.description = ""
            self.createdAt = Date()
        }
        self.todoToEdit = todoToEdit
    }
    
    // MARK: - Helpers
    var isEditing: Bool {
        todoToEdit != nil
    }
}
