//
//  TodoItemsFeedInteractor.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/10/24.
//

import TodoListWork

public final class TodoItemsFeedInteractor {
    private let feedLoader: TodoItemsFeedLoader
    private let feedSaver: TodoItemsFeedCache
    private let todoUpdater: TodoItemSaver
    private let todoDeleter: TodoItemDeleter
    private weak var loadingPresenter: TodoItemsFeedLoadingInteractorOutput?
    private weak var processingPresenter: TodoItemsOperationInteractorOutput?
    
    init(
        feedLoader: TodoItemsFeedLoader,
        feedSaver: TodoItemsFeedCache,
        todoUpdater: TodoItemSaver,
        todoDeleter: TodoItemDeleter
    ) {
        self.feedLoader = feedLoader
        self.feedSaver = feedSaver
        self.todoUpdater = todoUpdater
        self.todoDeleter = todoDeleter
    }
}

// MARK: - Todo Feed Laoading
extension TodoItemsFeedInteractor: TodoItemsFeedInteractorInput {
    public func loadFeed() {
        loadingPresenter?.didStartLoading()
        
        feedLoader.loadFeed { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(items):
                self.loadingPresenter?.didFinishLoading(with: items)
            case let .failure(error):
                self.loadingPresenter?.didFinishLoading(with: error)
            }
        }
    }
}

// MARK: - Todo Item Updating
extension TodoItemsFeedInteractor {
    public func updateTodoItem(_ item: TodoListWork.TodoItem) {
        todoUpdater.update(item) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success:
                self.processingPresenter?.didFinishOperation()
            case let .failure(error):
                self.processingPresenter?.didFinishOperation(with: error)
            }
        }
    }
}

// MARK: - Todo Item Deletion
extension TodoItemsFeedInteractor {
    public func deleteTodoItem(_ item: TodoListWork.TodoItem) {
        
        todoDeleter.delete(item) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success:
                self.processingPresenter?.didFinishOperation()
            case let .failure(error):
                self.processingPresenter?.didFinishOperation(with: error)
            }
        }
    }
}
