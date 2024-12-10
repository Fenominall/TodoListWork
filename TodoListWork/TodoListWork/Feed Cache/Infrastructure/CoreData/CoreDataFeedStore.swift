//
//  CoreDataStore.swift
//  TodoListWork
//
//  Created by Fenominall on 12/9/24.
//

import Foundation
import CoreData

public final class CoreDataFeedStore {
    // MARK: - Properties
    public static let storeURL = NSPersistentContainer
        .defaultDirectoryURL()
        .appending(path: "feed-store.sqlite")
    
    private static let modelName = "TodoItemsStore"
    private static let model = NSManagedObjectModel
        .with(
            name: modelName,
            in: Bundle(for: CoreDataFeedStore.self)
        )
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    enum StoreError: Swift.Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }
    
    //MARK: - Initialization
    public init(storeURL: URL) throws {
        guard let model = CoreDataFeedStore.model else {
            throw StoreError.modelNotFound
        }
        do {
            container = try NSPersistentContainer.load(
                name: CoreDataFeedStore.modelName,
                model: model,
                url: storeURL
            )
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    func performAsync(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
    
    // MARK: - Deinitialization
    deinit {
        cleanUpReferencesToPersistentStores()
    }
}
