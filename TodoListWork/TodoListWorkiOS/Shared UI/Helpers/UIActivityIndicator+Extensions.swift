//
//  UIActivityIndicator+Extensions.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/24/24.
//

import UIKit

extension UIActivityIndicatorView {
    func update(isRefreshing: Bool) {
        return isRefreshing ? startAnimating() : stopAnimating()
    }
}
