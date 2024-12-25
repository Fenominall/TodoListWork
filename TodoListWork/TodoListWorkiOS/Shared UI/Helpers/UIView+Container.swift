//
//  UIView+Container.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/20/24.
//

import UIKit

extension UIView {
    
    public func makeContainer() -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        container.isUserInteractionEnabled = true
        container.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            topAnchor.constraint(equalTo: container.topAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        bringSubviewToFront(container)
        
        return container
    }
}
