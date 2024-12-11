//
//  AppImages.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import Foundation
import UIKit

enum AppImages {
    case squareAndPencil
    case circle
    case checkMarkCircle
}

extension AppImages {
    var image: UIImage? {
        switch self {
            case .squareAndPencil:
            return UIImage(systemName: "square.and.pencil")
        case .circle:
            return UIImage(systemName: "circle")
        case .checkMarkCircle:
            return UIImage(systemName: "checkmark.circle")
        }
    }
}
