//
//  CombineHelpers.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import Foundation
import Combine
import TodoListWork

public extension HTTPClient {
    typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
    
    func getPublisher(from url: URL) -> Publisher {
        return Deferred {
            Future { completion in
                self.get(from: url, completion: completion)
            }
        }
        .eraseToAnyPublisher()
    }
}
