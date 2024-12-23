//
//  TodoItemsFeedPresenter.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import Foundation
import TodoListWork

public final class TodoItemsFeedPresenter {
    private let view: ResourceView
    private let errorView: ResourceErrorView
    private let loadingView: ResourceLoadingView
    private let interactor: TodoItemsFeedInteractorInput
    private let router: TodoItemsFeedRouterNavigator
    
    public init(
        view: ResourceView,
        errorView: ResourceErrorView,
        loadingView: ResourceLoadingView,
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

extension TodoItemsFeedPresenter: ResourceLoadingInteractorOutput {
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(ResourceLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with items: [TodoListWork.TodoItem]) {
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
        
        let sortedItems = items.sorted { $0.createdAt > $1.createdAt }
        
        view.display(sortedItems)
    }
    
    public func didFinishLoading(with error: any Error) {
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
        errorView.display(.error(message: "Нет подключения к интернету!"))
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
        router.addNewTodo()
    }
    
    public func navigateToTodoItemDetails(for item: TodoItem) {
        router.navigateToTodoItemDetails(for: item)
    }
}
