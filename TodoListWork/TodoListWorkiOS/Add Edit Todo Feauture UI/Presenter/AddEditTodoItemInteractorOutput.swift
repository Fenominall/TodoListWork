//
//  AddEditTodoItemInteractorOutput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/13/24.
//

import Foundation
import TodoListWork

public protocol AddEditTodoItemInteractorOutput: AnyObject {
    func didSaveTodo(_ todo: TodoItem)
    func didUpdateTodo(_ todo: TodoItem)
}
