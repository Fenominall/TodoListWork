//
//  AddEditTotoItemViewAdapter.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/14/24.
//

import Foundation
import TodoListWorkiOS

final class AddEditTotoItemViewAdapter: AddEditTodoItemViewInput {
    private weak var controller: AddEditTodoItemViewController?
    
    init(controller: AddEditTodoItemViewController) {
        self.controller = controller
    }
    
    func updateTodoWith(title: String, date: Date, description: String?) {
        controller?.updateUIwith(title: title, date: date, description: description)
    }
}
