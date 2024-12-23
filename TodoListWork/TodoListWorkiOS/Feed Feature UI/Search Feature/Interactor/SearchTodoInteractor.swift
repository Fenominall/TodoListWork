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
    public weak var presenter: ResourceLoadingInteractorOutput?

    public init(
        store: TodoSearcher,
        presenter: ResourceLoadingInteractorOutput? = nil
    ) {
        self.store = store
        self.presenter = presenter
    }
    
    public func searchTodo(query: String) {
        presenter?.didStartLoading()
        
        store.search(by: query) { [weak self] result in
            
            switch result {
            case let .success(items):
                self?.presenter?.didFinishLoading(with: items)
                
            case let .failure(error):
                self?.presenter?.didFinishLoading(with: error)
            }
        }
    }
}
