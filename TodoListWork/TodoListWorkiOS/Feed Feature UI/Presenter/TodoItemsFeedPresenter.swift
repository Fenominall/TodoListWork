//
//  TodoItemsFeedPresenter.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import Foundation
import TodoListWork

public final class TodoItemsFeedPresenter {
    private let view: TodoItemsFeedView
    private let errorView: TodoItemsErrorView
    private let loadingView: TodoItemsLoadingView
    private let interactor: TodoItemsFeedInteractorInput
    private let router: TodoItemsFeedRouterNavigator
    
    public init(
        view: TodoItemsFeedView,
        errorView: TodoItemsErrorView,
        loadingView: TodoItemsLoadingView,
        interactor: TodoItemsFeedInteractorInput,
        router: TodoItemsFeedRouterNavigator
    ) {
        self.view = view
        self.errorView = errorView
        self.loadingView = loadingView
        self.interactor = interactor
        self.router = router
    }
}

extension TodoItemsFeedPresenter {
    public func viewDidLoad() {
        interactor.loadFeed()
    }
    
    public func didRequestTodoItemDeletion(_ item: TodoItem) {
        interactor.deleteTodoItem(item)
    }
    
    public func didRequestTodoItemUpdate(_ item: TodoItem) {
        interactor.updateTodoItem(item)
    }
}

extension TodoItemsFeedPresenter: TodoItemsFeedLoadingInteractorOutput {
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(TodoItemsLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with items: [TodoListWork.TodoItem]) {
        loadingView.display(TodoItemsLoadingViewModel(isLoading: false))
        errorView.display(.noError)
        view.displayTasks(items)
    }
    
    public func didFinishLoading(with error: any Error) {
        loadingView.display(TodoItemsLoadingViewModel(isLoading: false))
        errorView.display(.error(message: error.localizedDescription))
    }
}

extension TodoItemsFeedPresenter: TodoItemsOperationInteractorOutput {
    public func didFinishOperation() {
        interactor.loadFeed()
    }
    
    public func didFinishOperation(with error: any Error) {
        errorView.display(.error(message: "Невозможно загрузить задачи!"))
    }
}

// MARK: - Router Navigation
extension TodoItemsFeedPresenter {
    public func navigateToAddTodoItem() {
        router.addNewTask()
    }
    
    public func navigateToTodoItemDetails(for item: TodoItem) {
        router.navigateToTodoItemDetails(for: item)
    }
}
