//
//  AddEditTodoItemNavigationRouter.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/13/24.
//

import UIKit

public protocol AddEditTodoRouter {
    func routeToTasksFeed()
}

public final class AddEditTodoNavigationRouter: AddEditTodoRouter {
    weak var controller: UIViewController?
    
    public init(controller: UIViewController? = nil) {
        self.controller = controller
    }
    
    public func routeToTasksFeed() {
        controller?.navigationController?.popViewController(animated: true)
    }
}
