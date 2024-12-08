//
//  TodoItem.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

struct TodoItem {
    let id: Int
    let title: String
    let description: String?
    let completed: Bool
    let createdAt: Date
    let userID: Int
}
