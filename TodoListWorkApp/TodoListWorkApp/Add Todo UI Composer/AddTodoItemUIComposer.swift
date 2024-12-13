//
//  AddEditTodoItemUIComposer.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/13/24.
//

import UIKit
import TodoListWork
import TodoListWorkiOS

final class AddTodoItemUIComposer {
    private init() {}
    
    static func composedWith(todoSaver: TodoItemSaver) -> AddEditTodoItemViewController {
        let viewModel = AddEditTodoItemViewModel()
        let controller = AddEditTodoItemViewController(viewModel: viewModel)
        let router = AddEditTodoNavigationRouter(controller: controller)
        
        let interactor = AddEditTodoItemInteractor(todoSaver: MainQueueDispatchDecorator(decoratee: todoSaver))
        
        let presenter = AddEditTodoItemPresenter(interactor: interactor, router: router)
        
        interactor.presenter = presenter
        
        return controller
    }
}
