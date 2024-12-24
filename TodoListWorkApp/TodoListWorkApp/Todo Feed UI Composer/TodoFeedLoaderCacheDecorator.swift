//
//  TodoFeedLoaderCacheDecorator.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import TodoListWork

final class TodoFeedLoaderCacheDecorator: FeedLoader {
    private let decoratee: FeedLoader
    private let cache: FeedCache
    
    init(decoratee: FeedLoader, cache: FeedCache) {
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

private extension FeedCache {
    func saveIgnoringResult(_ feed: [TodoItem]) {
        save(feed) { _ in }
    }
}
