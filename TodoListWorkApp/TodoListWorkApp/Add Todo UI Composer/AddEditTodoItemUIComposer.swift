//
//  AddEditTodoItemUIComposer.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/13/24.
//

import UIKit
import TodoListWork
import TodoListWorkiOS

final class AddEditTodoItemUIComposer {
    private init() {}
    
    static func composedWith(
        todoToEdit: TodoItem?,
        todoSaver: ItemSaveable) -> AddEditTodoItemViewController {
            let view = AddEditTodoItemViewController()
            let router = AddEditTodoNavigationRouter(controller: view)
            
            let interactor = AddEditTodoItemInteractor(
                todoSaver: MainQueueDispatchDecorator(decoratee: todoSaver)
            )
            
            let viewAdapter = AddEditTotoItemViewAdapter(controller: view)
            let presenter = AddEditTodoItemPresenter(
                interactor: interactor,
                router: router,
                view: viewAdapter,
                todoToEdit: todoToEdit
            )
            
            interactor.presenter = presenter
            view.onSave = presenter.saveTodo
            view.onViewDidLoad = presenter.loadData
            view.presenter = presenter
            
            return view
        }
}
