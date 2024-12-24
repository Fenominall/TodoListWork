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
    
    private lazy var store: FeedStore = {
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
    
    private lazy var localSearchTodo: ItemSearchable = {
        LocalTodoSearcher(store: store)
    }()
    
    private lazy var baseURL = URL(string: "https://dummyjson.com/todos")!
    private var navigationController = UINavigationController()
    
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
                todoSearcher: localSearchTodo,
                navigationController: navigationController,
                selection: makeEditTodoComposer,
                addnewTodo: makeAddTodoComposer,
                shareTodo: makeTodoSharedComposer
            )
        
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
    
    private func makeEditTodoComposer(for item: TodoItem?) -> UIViewController {
        return AddEditTodoItemUIComposer.composedWith(
            todoToEdit: item,
            todoSaver: feedLoaderFactory.makeLocalFeedLoader())
    }
    
    private func makeAddTodoComposer() -> UIViewController {
        return AddEditTodoItemUIComposer.composedWith(
            todoToEdit: nil,
            todoSaver: feedLoaderFactory.makeLocalFeedLoader())
    }
    
    private func makeTodoSharedComposer(for item: TodoItem) -> UIActivityViewController {
        return ShareTodoUIComposer.composed(with: item)
    }
}

