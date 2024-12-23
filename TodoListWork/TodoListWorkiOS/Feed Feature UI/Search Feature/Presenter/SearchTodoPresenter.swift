//
//  SearchTodoPresenter.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/21/24.
//

import Foundation
import TodoListWork


public final class SearchTodoPresenter {
    private let interactor: SearchTodoInteractorInput
    
    public init(
        interactor: SearchTodoInteractorInput
    ) {
        self.interactor = interactor
    }
}

extension SearchTodoPresenter: SearchTodoInteractorOutput {
    public func didFinishSearchingTodos(with result: [TodoItem]) {
        
    }
    
    public func didFinishSearchingTodos(with error: any Error) {
        
    }
}