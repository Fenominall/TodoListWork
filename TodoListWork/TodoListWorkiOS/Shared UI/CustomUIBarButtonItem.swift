//
//  CustomUIBarButtonItem.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/15/24.
//

import UIKit

public protocol CustomUIBarButtonItemProviding {
    func createCutomUIBarButtonItemWith(
        title: String,
        image: UIImage?,
        color: UIColor,
        target: Any?,
        action: Selector,
        imagePlacement: NSDirectionalRectEdge,
        imagePadding: CGFloat,
        contentInsets: NSDirectionalEdgeInsets
    ) -> UIBarButtonItem
}

public final class BackButtonProvider: CustomUIBarButtonItemProviding {
    public init() {}
    
    public func createCutomUIBarButtonItemWith(
        title: String,
        image: UIImage?,
        color: UIColor,
        target: Any?,
        action: Selector,
        imagePlacement: NSDirectionalRectEdge = .leading,
        imagePadding: CGFloat = 6,
        contentInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: -8,
            bottom: 0,
            trailing: 0
        )
    ) -> UIBarButtonItem {
        let backButton = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.image = image
        config.title = title
        config.baseForegroundColor = color
        config.imagePlacement = .leading
        config.imagePadding = 6
        config.contentInsets = contentInsets
        backButton.configuration = config
        
        backButton.addTarget(target, action: action, for: .touchUpInside)
        
        return UIBarButtonItem(customView: backButton)
    }
}
