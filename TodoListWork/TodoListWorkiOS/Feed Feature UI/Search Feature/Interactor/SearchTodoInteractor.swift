//
//  SearchTodoInteractor.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/20/24.
//

import Foundation
import TodoListWork

public final class SearchTodoInteractor: SearchTodoInteractorInput {
    private let store: TodoSearcher
    public weak var presenter: SearchTodoInteractorOutput?
    
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
