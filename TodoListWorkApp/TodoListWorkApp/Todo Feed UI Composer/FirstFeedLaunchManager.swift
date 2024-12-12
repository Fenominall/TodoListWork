//
//  FirstFeedLaunchManager.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/12/24.
//

import Foundation

final class FirstFeedLaunchManager {
    private let hasLaunchedKey = "hasLaunchedBefore"
    private let userDefaults = UserDefaults.standard
    
    func isFirstLaunch() -> Bool {
        let hasLaunchedBefore = userDefaults.bool(forKey: hasLaunchedKey)
        
        if !hasLaunchedBefore {
            userDefaults.setValue(true, forKey: hasLaunchedKey)
            return true
        }
        return false
    }
}
