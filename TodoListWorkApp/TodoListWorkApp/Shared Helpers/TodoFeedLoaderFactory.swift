//
//  TodoFeedLoaderFactory.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import Foundation
import TodoListWork

final class TodoFeedLoaderFactory {
    private let client: HTTPClient
    private let url: URL
    private let localStore: FeedStore
    private let firstFeedLaunchManager: FirstFeedLaunchManager

    init(
        client: HTTPClient,
        url: URL,
        localStore: FeedStore,
        firstFeedLaunchManager: FirstFeedLaunchManager
    ) {
        self.client = client
        self.url = url
        self.localStore = localStore
        self.firstFeedLaunchManager = firstFeedLaunchManager
    }

    func makeRemoteFeedLoader() -> RemoteFeedLoader {
        return RemoteFeedLoader(url: url, client: client)
    }

    func makeLocalFeedLoader() -> LocalFeedCacheManager {
        return LocalFeedCacheManager(store: localStore)
    }

    private func makeCacheDecorator(decoratee: FeedLoader) -> TodoFeedLoaderCacheDecorator {
        return TodoFeedLoaderCacheDecorator(decoratee: decoratee, cache: makeLocalFeedLoader())
    }

    /// Facade method to create the appropriate loader
    func makeFeedLoader() -> FeedLoader {
        let remoteLoader = makeRemoteFeedLoader()
        let localLoader = makeLocalFeedLoader()
        
        if firstFeedLaunchManager.isFirstLaunch() {
            return TodoFeedLoaderWithFallbackComposite(
                primary: makeCacheDecorator(decoratee: remoteLoader),
                fallback: localLoader)
        } else {
            return localLoader
        }
    }
}
