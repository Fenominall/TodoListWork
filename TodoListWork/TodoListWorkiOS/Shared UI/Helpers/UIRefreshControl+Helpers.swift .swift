//
//  UIRefreshControl+Helpers.swift .swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/12/24.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        return isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
