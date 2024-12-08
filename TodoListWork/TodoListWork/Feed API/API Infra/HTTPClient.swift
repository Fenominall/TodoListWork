//
//  HTTPClient.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
