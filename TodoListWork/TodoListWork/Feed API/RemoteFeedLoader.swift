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
    
    private enum Error: Swift.Error {
        case invalidData
        case connectivity
    }
    
    // MARK: - Methods
    public func load(completion: @escaping (LoadResult) -> Void) {
        client.get(from: url) { [weak self] result in
            // safety mechanism to prevent executing logic in the closure when the self instance(RemoteFeedLoader) has been deallocated
            guard self != nil else { return }
            do {
                switch result {
                    
                case let .success((data, response)):
                    let todos = try TodoFeedItemsMapper.map(data, from: response)
                    completion(.success(todos))
                case .failure:
                    completion(.failure(Error.connectivity))
                }
            } catch {
                completion(.failure(Error.invalidData))
            }
        }
    }
}
