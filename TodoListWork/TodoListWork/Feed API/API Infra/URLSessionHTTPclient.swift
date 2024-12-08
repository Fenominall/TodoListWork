//
//  URLSessionHTTPclient.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

public final class  URLSessionHTTPclient: HTTPClient {
    // MARK: - Properties
    public let session: URLSession
    
    // MARK: - Lifecycle
    public init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - Methods
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        
    }
}
