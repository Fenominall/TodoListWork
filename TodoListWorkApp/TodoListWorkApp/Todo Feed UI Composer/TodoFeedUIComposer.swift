//
//  TodoItemsFeedUIComposer.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import UIKit
import TodoListWork
import TodoListWorkiOS

final class TodoFeedUIComposer {
    private init() {}
    
    static func todoFeedComposedWith(
        feedLoader: TodoItemsFeedLoader,
        todoSaver: TodoItemSaver,
        totDeleter: TodoItemDeleter,
        navigationController: UINavigationController,
        selection: @escaping (TodoItem) -> UIViewController
    ) -> TodoListViewController {
        return TodoListViewController()
    }
}
