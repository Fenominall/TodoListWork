//
//  TasksFeedLoaderWithFallbackComposite.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import Foundation
import TodoListWork

final class TodoFeedLoaderWithFallbackComposite: TodoItemsFeedLoader {
    private let primary: TodoItemsFeedLoader
    private let fallback: TodoItemsFeedLoader
    
    init(primary: TodoItemsFeedLoader, fallback: TodoItemsFeedLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    
    func loadFeed(completion: @escaping (TodoItemsFeedLoader.Result) -> Void) {
        primary.loadFeed { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                print("FAIL LOADING")
                self?.fallback.loadFeed(completion: completion)
            }
        }
    }
}
