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
}

extension SearchTodoPresenter: SearchTodoInteractorOutput {
    public func didFinishSearching(with result: [TodoItem]) {
        
    }
    
    public func didFinishSearching(with error: any Error) {
        
    }
}
