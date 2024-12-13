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
    public let todoSaver: TodoItemSaver
    
    init(todoSaver: TodoItemSaver) {
        self.todoSaver = todoSaver
    }
    
    public func save(_ item: TodoListWork.TodoItem) {
        
    }
    
    public func update(_ item: TodoListWork.TodoItem) {
        
    }
}
