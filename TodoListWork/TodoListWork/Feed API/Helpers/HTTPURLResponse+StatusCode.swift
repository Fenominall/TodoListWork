//
//  HTTPURLResponse+StatusCode.swift
//  TodoListWork
//
//  Created by Fenominall on 12/8/24.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool { statusCode == HTTPURLResponse.OK_200 }
}
