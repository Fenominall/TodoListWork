//
//  TodoItemsOperationInteractorOutput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import Foundation

// Protocol for handling operations like update, delete, etc.
public protocol TodoItemsOperationInteractorOutput: AnyObject {
    func didFinishOperation() // Generic for any operation
    func didFinishOperation(with error: Error)
}
