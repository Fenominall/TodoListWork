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
    case microphoneFill
    case trash
    case squareAndArrowUp
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
        case .microphoneFill:
            return UIImage(systemName: "microphone.fill")
        case .trash:
            return UIImage(systemName: "trash")
        case .squareAndArrowUp:
            return UIImage(systemName: "square.and.arrow.up")
        }
    }
}
