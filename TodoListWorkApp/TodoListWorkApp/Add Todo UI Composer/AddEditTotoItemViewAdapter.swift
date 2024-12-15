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
    
    func updateWith(title: String, description: String?) {
        
    }
    
    func showError(_ message: String) {
        
    }
}