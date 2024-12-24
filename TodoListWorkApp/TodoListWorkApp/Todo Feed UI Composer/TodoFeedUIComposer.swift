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
        feedLoader: FeedLoader,
        todoSaver: TodoItemSaver,
        todoDeleter: TodoItemDeleter,
        todoSearcher: TodoSearcher,
        navigationController: UINavigationController,
        selection: @escaping (TodoItem) -> UIViewController,
        addnewTodo: @escaping () -> UIViewController,
        shareTodo: @escaping (TodoItem) -> UIActivityViewController
    ) -> ListViewController {
        
        // MARK: - Loading
        let router = TodoItemsFeedRouter(
            navigationController: navigationController,
            todoDetailComposer: selection,
            addTodoComposer: addnewTodo,
            shareTodoComposer: shareTodo
        )
        
        let view = ListViewController()
        let loadingInteractor = TodoItemsFeedInteractor(
            feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader),
            todoSaver: MainQueueDispatchDecorator(decoratee: todoSaver),
            todoDeleter: MainQueueDispatchDecorator(decoratee: todoDeleter)
        )
        
        let viewAdapter = TodoFeedViewAdapter(
            controller: view,
            selection: router.navigateToTodoItemDetails,
            onShare: router.shareTodo
        )
        
        let loadingPresenter = TodoItemsFeedPresenter(
            view: viewAdapter,
            errorView: WeakRefVirtualproxy(view),
            loadingView: WeakRefVirtualproxy(view),
            interactor: loadingInteractor,
            router: router
        )
        
        viewAdapter.setOnDeleteHandler { [weak loadingPresenter] item in
            loadingPresenter?.didRequestTodoItemDeletion(item)
            view.onRefresh?()
        }
        
        viewAdapter.setOnUpdateHandler { [weak loadingPresenter] item in
            loadingPresenter?.didRequestTodoItemUpdate(item)
            view.onRefresh?()
        }
        
        view.addNewTodo = loadingPresenter.navigateToAddTodoItem
        view.onRefresh = loadingPresenter.viewDidLoad
        loadingInteractor.loadingPresenter = loadingPresenter
        loadingInteractor.processingPresenter = loadingPresenter
        
        // MARK: - Searching
        let searchInteractor = SearchTodoInteractor(store: todoSearcher)
            
        let searchPresenter = SearchTodoPresenter(
            view: viewAdapter,
            errorView: WeakRefVirtualproxy(view),
            loadingView: WeakRefVirtualproxy(view),
            interactor: searchInteractor
        )
         
        searchInteractor.presenter = searchPresenter
        
        return view
    }
}
