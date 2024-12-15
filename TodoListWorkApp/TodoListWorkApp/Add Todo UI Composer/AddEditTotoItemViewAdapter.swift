//
//  AddEditTotoItemViewAdapter.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/14/24.
//

import Foundation
import TodoListWorkiOS

final class AddEditTotoItemViewAdapter: AddEditTodoItemViewInput {
    func updateTodoWith(title: String, date: String, description: String?) {
        
    }
    
    private weak var controller: AddEditTodoItemViewController?
    
    init(controller: AddEditTodoItemViewController) {
        self.controller = controller
    }
}
