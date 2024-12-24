//
//  SearchTodoInteractor.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/20/24.
//

import Foundation
import TodoListWork

public final class SearchTodoInteractor: SearchTodoInteractorInput {
    private let store: ItemSearchable
    public weak var presenter: ResourceLoadingInteractorOutput?

    public init(
        store: ItemSearchable
    ) {
        self.store = store
    }
    
    public func search(by query: String) {
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
