//
//  AddEditTodoItemViewInput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/14/24.
//

import Foundation

public protocol AddEditTodoItemViewInput: AnyObject {
    func updateWith(title: String, description: String?)
}
