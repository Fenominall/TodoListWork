//
//  ShareTodoUIComposer.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/19/24.
//

import TodoListWork
import TodoListWorkiOS

final class ShareTodoUIComposer {
    private init() {}
    
    static func composed(with item: TodoItem) -> ShareTodoUIActivityViewController {
        let viewModel = ShareTodoItemViewModel(with: item)
        
        let view = ShareTodoUIActivityViewController(viewModel: viewModel)
        return view
    }
}
