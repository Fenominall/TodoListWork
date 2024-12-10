//
//  CoreDataCacheErrors.swift
//  TodoListWork
//
//  Created by Fenominall on 12/10/24.
//

import Foundation

enum CoreDataFeedStoreError: Error {
    case unableToCreateMutableCopy
    case todokNotFound
    case todoIDMismatch
}
