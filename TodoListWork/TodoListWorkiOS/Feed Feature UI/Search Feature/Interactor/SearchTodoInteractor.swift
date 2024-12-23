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
        store.search(by: query) { [weak self] result in
            
            switch result {
            case let .success(items):
                self?.presenter?.didFinishSearching(with: items)
                
            case let .failure(error):
                self?.presenter?.didFinishSearching(with: error)
            }
        }
    }
}
