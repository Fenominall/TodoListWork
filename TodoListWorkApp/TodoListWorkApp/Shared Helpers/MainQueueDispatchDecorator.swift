//
//  MainQueueDispatchDecorator.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import Foundation
import TodoListWork
// Utility for ensuring that operations targeting the main thread are executed safely and correctly it can help to prevent race conditions and crashes that may occur from executing UI-related code on background threads.
final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void){
        guard Thread.isMainThread else {
            return DispatchQueue.main.asyncAndWait(execute: completion)
        }
        completion()
    }
}
