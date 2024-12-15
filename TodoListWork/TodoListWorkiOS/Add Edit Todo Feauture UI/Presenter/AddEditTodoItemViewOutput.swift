//
//  AddEditTodoItemsPresenterOutput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/15/24.
//

import Foundation

public protocol AddEditTodoItemViewOutput: AnyObject {
    func updatePresenterWith(_ title: String, date: Date, description: String?)
}
