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
        todoSaver.save(item) { [weak self] result in
            switch result {
                
            case .success:
                self?.presenter?.didSaveTodo()
            case .failure(_):
                // TODO
                break
            }
        }
    }
    
    public func update(_ item: TodoListWork.TodoItem) {
        todoSaver.update(item) { [weak self] result in
            switch result {
                
            case .success:
                self?.presenter?.didSaveTodo()
            case .failure(_):
                // TODO
                break
            }
        }
    }
}

