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
    
    private lazy var store: TodoItemsStore = {
        do {
            return try CoreDataFeedStore(
                storeURL: CoreDataFeedStore.storeURL
            )
        } catch {
            print("Error instantiating CoreData store: \(error.localizedDescription)")
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            return NullStore()
        }
    }()
    private lazy var baseURL = URL(string: "https://dummyjson.com/todos")!
    private let navigationController = UINavigationController()
    
    private lazy var firstLaunchManager = FirstFeedLaunchManager()
    private lazy var feedLoaderFactory = TodoFeedLoaderFactory(
        client: httpClient,
        url: baseURL,
        localStore: store,
        firstFeedLaunchManager: firstLaunchManager
    )
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        modifyUINavigationBarAppearence()
        configureWindow()
    }
    
    private func configureWindow() {
        let todoFeedVCComposer = TodoFeedUIComposer
            .todoFeedComposedWith(
                feedLoader: feedLoaderFactory.makeFeedLoader(),
                todoSaver: feedLoaderFactory.makeLocalFeedLoader(),
                todoDeleter: feedLoaderFactory.makeLocalFeedLoader(),
                navigationController: navigationController) { _ in
                    // Todo
                    UIViewController()
                } addnewTodo: {
                    UIViewController()
                }

        
        navigationController.viewControllers = [todoFeedVCComposer]
        window?.rootViewController = navigationController
        window?.overrideUserInterfaceStyle = .dark // Force dark mode
        window?.makeKeyAndVisible()
    }
    
    private func modifyUINavigationBarAppearence() {
        // Set global appearance for UINavigationBar
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = .systemYellow // Sets back button and other bar item colors
    }
}

