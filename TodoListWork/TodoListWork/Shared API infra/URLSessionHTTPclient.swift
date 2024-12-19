//
//  URLSessionHTTPclient.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

public final class URLSessionHTTPclient: HTTPClient {
    // MARK: - Properties
    public let session: URLSession
    
    // MARK: - Lifecycle
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    // MARK: - Methods
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        session.dataTask(with: url) { data, response, error in
            completion(Result {
                if let error = error { throw error }
                guard let data = data,
                      let response = response as? HTTPURLResponse else {
                    throw UnexpectedValuesRepresentation()
                }
                return (data, response)
            })
        }
        .resume()
    }
}
