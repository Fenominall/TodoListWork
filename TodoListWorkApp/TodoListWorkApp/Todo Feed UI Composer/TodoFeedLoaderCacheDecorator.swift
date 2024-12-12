//
//  TodoFeedLoaderCacheDecorator.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import TodoListWork

final class TodoFeedLoaderCacheDecorator: TodoItemsFeedLoader {
    private let decoratee: TodoItemsFeedLoader
    private let cache: TodoItemsFeedCache
    
    init(decoratee: TodoItemsFeedLoader, cache: TodoItemsFeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }

    func loadFeed(completion: @escaping (TodoItemsFeedLoader.Result) -> Void) {
        decoratee.loadFeed { [weak self] result in
            completion(result.map { feed in
                self?.cache.saveIgnoringResult(feed)
                return feed
            })
        }
    }
}

private extension TodoItemsFeedCache {
    func saveIgnoringResult(_ feed: [TodoItem]) {
        save(feed) { _ in }
    }
}
