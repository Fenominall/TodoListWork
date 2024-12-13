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
    private var originalTitle: String
    private var originalDescription: String?
    
    public var onSaveAddTodo: ((TodoItem) -> Void)?
    public var onSaveUpdateTodo: ((TodoItem) -> Void)?
    
    private(set) var currentTitle: String
    private(set) var currentDescription: String?
    // MARK: - Lifecycle
    // MARK: - Lifecycle
    public init(todoToEdit: TodoItem? = nil) {
        self.todoToEdit = todoToEdit
        self.originalTitle = todoToEdit?.title ?? ""
        self.originalDescription = todoToEdit?.description
        self.currentTitle = self.originalTitle
        self.currentDescription = self.originalDescription
    }
    
    // MARK: - Helpers
    var isEditing: Bool {
        todoToEdit != nil
    }
    
    var hasChanges: Bool {
        currentTitle != originalTitle || currentDescription != originalDescription
    }
    
    func updateTitle(_ title: String) {
        self.currentTitle = title
    }
    
    func updateDescription(_ description: String) {
        self.currentDescription = description
    }
    
    func saveTodo() {
        guard hasChanges else { return }
        let todoItem = TodoItem(
            id: todoToEdit?.id ?? UUID(),
            title: currentTitle,
            description: currentDescription,
            completed: todoToEdit?.completed ?? false,
            createdAt: todoToEdit?.createdAt ?? Date(),
            userId: todoToEdit?.userId ?? generateUniqueInt()
        )
        isEditing ? onSaveUpdateTodo?(todoItem) : onSaveAddTodo?(todoItem)
    }
    
    // Generate a unique Int based on UUID
    private func generateUniqueInt() -> Int {
        let uuid = UUID().uuidString
        let hash = uuid.hashValue
        return abs(hash) // Ensure a positive integer
    }
}
