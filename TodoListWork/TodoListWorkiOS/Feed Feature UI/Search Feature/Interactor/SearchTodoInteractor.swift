//
//  SearchTodoInteractor.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/20/24.
//

import Foundation
import TodoListWork

public protocol SearchTodoInteractorInput {
    func searchTodo(query: String)
}

public final class SearchTodoInteractor: SearchTodoInteractorInput {
    private let store: TodoSearcher
    
    init(store: TodoSearcher) {
        self.store = store
    }
    
    public func searchTodo(query: String) {
        store.search(by: query) { result in
            switch result {
                
            case let .success(items): break
                
            case let .failure(error): break
            }
        }
    }
}
