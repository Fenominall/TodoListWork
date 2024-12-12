//
//  SceneDelegate.swift
//  TodoListWorkApp
//
//  Created by Fenominall on 12/11/24.
//

import UIKit
import TodoListWork
import TodoListWorkiOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPclient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var baseURL = URL(string: "https://dummyjson.com/todos")!
    private let navigationController = UINavigationController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        configureWindow()
        modifyUINavigationBarAppearence()
    }
    
    private func configureWindow() {
        let viewController = TodoListViewController()
        
        navigationController.viewControllers = [viewController]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func modifyUINavigationBarAppearence() {
        // Set global appearance for UINavigationBar
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = .systemYellow // Sets back button and other bar item colors
    }
}

