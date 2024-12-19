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
        addnewTodo: @escaping () -> UIViewController,
        shareTodo: @escaping (TodoItem) -> UIActivityViewController
    ) -> ListViewController {
        
        let router = TodoItemsFeedRouter(
            navigationController: navigationController,
            todoDetailComposer: selection,
            addTodoComposer: addnewTodo,
            shareTodoComposer: shareTodo
        )
        
        let view = ListViewController()
        let interactor = TodoItemsFeedInteractor(
            feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader),
            todoSaver: MainQueueDispatchDecorator(decoratee: todoSaver),
            todoDeleter: MainQueueDispatchDecorator(decoratee: todoDeleter)
        )
        
        let viewAdapter = TodoFeedViewAdapter(
            controller: view,
            selection: router.navigateToTodoItemDetails,
            onShare: router.shareTodo
        )
        
        let presenter = TodoItemsFeedPresenter(
            view: viewAdapter,
            errorView: WeakRefVirtualproxy(view),
            loadingView: WeakRefVirtualproxy(view),
            interactor: interactor,
            router: router
        )
        
        viewAdapter.setOnDeleteHandler { [weak presenter] item in
            presenter?.didRequestTodoItemDeletion(item)
            view.onRefresh?()
        }
        
        viewAdapter.setOnUpdateHandler { [weak presenter] item in
            presenter?.didRequestTodoItemUpdate(item)
            view.onRefresh?()
        }
        
        view.addNewTodo = presenter.navigateToAddTodoItem
        view.onRefresh = presenter.viewDidLoad
        interactor.loadingPresenter = presenter
        interactor.processingPresenter = presenter
        
        return view
    }
}
