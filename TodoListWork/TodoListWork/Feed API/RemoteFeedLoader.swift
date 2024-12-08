//
//  RemoteFeedLoader.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
    // MARK: - Properties
    private let url: URL
    private let client: HTTPClient
    
    public typealias LoadResult = FeedLoader.Result
    
    // MARK: - Lifecycle
    public init(
        url: URL,
        client: HTTPClient
    ) {
        self.url = url
        self.client = client
    }
    
    // MARK: - Methods
    public func loadFeed(completion: @escaping (LoadResult) -> Void) {
        client.get(from: url) { [weak self] result in
            switch result {
                
            case .success((_, _)):
                break
            case .failure(_):
                break
            }
        }
    }
}
