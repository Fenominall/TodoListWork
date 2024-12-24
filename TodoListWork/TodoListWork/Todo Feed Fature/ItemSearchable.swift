//
//  TodoSearcher.swift
//  TodoListWork
//
//  Created by Fenominall on 12/20/24.
//

import Foundation

public protocol ItemSearchable {
    typealias Result = Swift.Result<[TodoItem], Error>
    
    func search(by query: String, completion: @escaping (Result) -> Void)
}
