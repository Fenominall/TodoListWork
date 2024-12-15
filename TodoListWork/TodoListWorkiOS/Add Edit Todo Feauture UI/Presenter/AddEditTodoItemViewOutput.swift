//
//  AddEditTodoItemsPresenterOutput.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/15/24.
//

import Foundation

public protocol AddEditTodoItemViewOutput: AnyObject {
    func updateTitle(_ title: String)
    func updateDate(_ date: Date)
    func updateDescription(_ description: String?)
}
