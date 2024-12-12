//
//  DateConvertingExtensions.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/12/24.
//

import Foundation
// Exmaple - Date() -> 12/12/24
func dateConvertedToDMYString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter.string(from: date)
}
