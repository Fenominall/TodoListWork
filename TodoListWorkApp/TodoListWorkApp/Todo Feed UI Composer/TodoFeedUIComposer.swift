//
//  TodoItemsFeedUIComposer.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import UIKit
import TodoListWork
import TodoListWorkiOS

final class TodoFeedUIComposer {
    private init() {}
    
    static func todoFeedComposedWith(
        feedLoader: TodoItemsFeedLoader,
        todoSaver: TodoItemSaver,
        todoDeleter: TodoItemDeleter,
        navigationController: UINavigationController,
        selection: @escaping (TodoItem) -> UIViewController,
        addnewTodo: @escaping () -> UIViewController
    ) -> TodoListViewController {
        let router = TodoItemsFeedRouter(
            navigationController: navigationController,
            todoDetailComposer: selection,
            addTodoComposer: addnewTodo
        )
        
        let view = TodoListViewController()
        let interactor = TodoItemsFeedInteractor(
            feedLoader: feedLoader,
            todoSaver: todoSaver,
            todoDeleter: todoDeleter
        )
        
        let viewAdapter = TodoFeedViewAdapter(cotroller: view) { todo in
            router.navigateToTodoItemDetails(for: todo)
            return selection(todo)
        }
        
        let presenter = TodoItemsFeedPresenter(
            view: viewAdapter,
            errorView: WeakRefVirtualproxy(view),
            loadingView: WeakRefVirtualproxy(view),
            interactor: interactor,
            router: router
        )
        
        view.onRefresh = presenter.viewDidLoad
        interactor.loadingPresenter = presenter
        interactor.processingPresenter = presenter
        
        return view
    }
}
