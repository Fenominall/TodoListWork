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
    
    init(interactor: SearchTodoInteractorInput) {
        self.interactor = interactor
    }
}

extension SearchTodoPresenter: SearchTodoInteractorOutput {
    public func didFinishSearchingTodo(with result: [TodoListWork.TodoItem]) {
        
    }
    
    public func didFinishSearchingTodo(with error: any Error) {
        
    }
}
