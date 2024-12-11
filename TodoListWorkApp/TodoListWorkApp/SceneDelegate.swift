//
//  SceneDelegate.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/11/24.
//

import UIKit
import TodoListWorkiOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
        modifyUINavigationBarAppearence()
        
        let window = UIWindow(windowScene: windowScene)
        let viewController = TodoListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func modifyUINavigationBarAppearence() {
        // Set global appearance for UINavigationBar
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = .systemYellow // Sets back button and other bar item colors
    }
}

