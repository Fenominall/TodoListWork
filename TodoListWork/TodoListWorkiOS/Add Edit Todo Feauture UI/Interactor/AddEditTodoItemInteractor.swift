//
//  AddEditTodoItemInteractor.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/13/24.
//

import Foundation
import TodoListWork

public protocol AddEditTodoItemInteractorInput {
    func save(_ item: TodoItem)
    func update(_ item: TodoItem)
}

public final class AddEditTodoItemInteractor: AddEditTodoItemInteractorInput {
    public weak var presenter: AddEditTodoItemInteractorOutput?
    private let todoSaver: TodoItemSaver
    
    public init(todoSaver: TodoItemSaver) {
        self.todoSaver = todoSaver
    }
    
    public func save(_ item: TodoListWork.TodoItem) {
        todoSaver.save(item) { _ in
            // TODO
        }
    }
    
    public func update(_ item: TodoListWork.TodoItem) {
        todoSaver.update(item) { _ in
            // TODO
        }
    }
}

