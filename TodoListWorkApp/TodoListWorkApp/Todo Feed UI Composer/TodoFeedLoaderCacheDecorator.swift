//
//  TodoFeedLoaderCacheDecorator.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import TodoListWork

final class TodoFeedLoaderCacheDecorator: FeedLoader {
    private let decoratee: FeedLoader
    private let cache: TodoItemsFeedCache
    
    init(decoratee: FeedLoader, cache: TodoItemsFeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }

    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
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
