//
//  SearchTodoPresenter.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/21/24.
//

import Foundation
import TodoListWork


public final class SearchTodoPresenter {
    private let view: ResourceView
    private let errorView: ResourceErrorView
    private let loadingView: ResourceLoadingView
    private let interactor: SearchTodoInteractorInput
    
    public init(
        view: ResourceView,
        errorView: ResourceErrorView,
        loadingView: ResourceLoadingView,
        interactor: SearchTodoInteractorInput
    ) {
        self.view = view
        self.errorView = errorView
        self.loadingView = loadingView
        self.interactor = interactor
    }
    
    public func search(by query: String) {
        interactor.searchTodo(by: query)
    }
}

extension SearchTodoPresenter: ResourceLoadingInteractorOutput {
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
        errorView.display(.error(message: "Ничего не найдено!"))
    }
}
