//
//  AddEditTodoItemPresenter.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/13/24.
//

import Foundation
import TodoListWork

public final class AddEditTodoItemPresenter {
    // MARK: - Properties
    private let interactor: AddEditTodoItemInteractorInput
    private let router: AddEditTodoRouter
    private let view: AddEditTodoItemViewInput
    
    private let todoToEdit: TodoItem?
    private var currentTitle: String
    private var currentDate: Date
    private var currentDescription: String?
    
    // MARK: - Lifecycle
    public init(
        interactor: AddEditTodoItemInteractorInput,
        router: AddEditTodoRouter,
        view: AddEditTodoItemViewInput,
        todoToEdit: TodoItem?
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.todoToEdit = todoToEdit
        self.currentTitle = todoToEdit?.title ?? ""
        self.currentDate = todoToEdit?.createdAt ?? Date()
        self.currentDescription = todoToEdit?.description
    }
    
    // MARK: - Helpers
    private var hasChanges: Bool {
        currentTitle != todoToEdit?.title ||
        currentDescription != todoToEdit?.description ||
        hasDateChanged
    }
    
    private var hasDateChanged: Bool {
        return todoToEdit?.createdAt != currentDate ? true : false
    }
    
    private var isTitleValid: Bool {
        !currentTitle.isEmpty
    }
    
    private var isEditing: Bool {
        todoToEdit != nil
    }
    
    public func loadData() {
        view.updateTodoWith(
            title: currentTitle,
            date: currentDate,
            description: currentDescription
        )
    }
    
    public func saveTodo() {
        guard hasChanges else {
            router.routeToTasksFeed()
            return
        }
        
        guard isTitleValid else {
            router.routeToTasksFeed()
            return
        }
                
        let todoItem = TodoItem(
            id: todoToEdit?.id ?? UUID(),
            title: currentTitle,
            description: currentDescription,
            completed: todoToEdit?.completed ?? false,
            createdAt: currentDate,
            userId: todoToEdit?.userId ?? generateUniqueInt()
        )
        
        isEditing ?
        interactor.update(todoItem) :
        interactor.save(todoItem)
    }
    
    // Generate a unique Int based on UUID
    private func generateUniqueInt() -> Int {
        let uuid = UUID().uuidString
        let hash = uuid.hashValue
        return abs(hash) // Ensure a positive integer
    }
}

// MARK: - AddEditTodoItemViewOutput
extension AddEditTodoItemPresenter: AddEditTodoItemViewOutput {
    public func updatePresenterWith(
        _ title: String,
        date: Date,
        description: String?
    ) {
        currentTitle = title
        currentDate = date
        currentDescription = description
    }
}

// MARK: - AddEditTodoItemInteractorOutput
extension AddEditTodoItemPresenter: AddEditTodoItemInteractorOutput {
    public func didSaveTodo() {
        router.routeToTasksFeed()
    }
}
