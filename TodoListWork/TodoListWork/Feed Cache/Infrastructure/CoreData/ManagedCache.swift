//
//  ManagedCache.swift
//  TodoListWork
//
//  Created by Fenominall on 12/10/24.
//

import Foundation
import CoreData

@objc(ManagedCache)
final class ManagedCache: NSManagedObject {
    @NSManaged var feed: NSOrderedSet
}

// MARK: - Retrieving
extension ManagedCache {
    var localeTodoFeed: [LocalTodoItem] {
        // Ensure cache is not nil and contains valid objects
        guard let cache = feed.array as? [ManagedTodoItem] else {
            return []
        }
        
        return cache.compactMap { $0.local }
    }
    
    static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
        let request = NSFetchRequest<ManagedCache>(entityName: ManagedCache.entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
}

// MARK: - Inserting
extension ManagedCache {
    static func fetchOrCreateCache(in context: NSManagedObjectContext) throws -> ManagedCache {
        guard let cache = try ManagedCache.find(in: context) else {
            return ManagedCache(context: context)
        }
        return cache
    }
    
    func updateCache(
        with items: [LocalTodoItem],
        in context: NSManagedObjectContext
    ) throws {
        let managedCache = try ManagedCache.fetchOrCreateCache(in: context)
        
        // Get existing tasks to avoid duplicates
        let existingTasks = feed.mutableCopy() as? NSMutableOrderedSet ?? NSMutableOrderedSet()
        
        // Filter and add only new tasks
        let newTasks = ManagedTodoItem.createBatch(from: items, in: context, with: managedCache)
        addItemsToCache(existingTasks, newItems: newTasks)
        
        // Safely update the cache feed
        guard let updatedCache = existingTasks.copy() as? NSOrderedSet else {
            throw CoreDataFeedStoreError.missingManagedObjectContext
        }
        feed = updatedCache
    }
    
    private func addItemsToCache(
        _ existingItems: NSMutableOrderedSet,
        newItems: [ManagedTodoItem]
    ) {
        existingItems.addObjects(from: newItems)
    }
    
    static func insert(
        _ tasks: [LocalTodoItem],
        in context: NSManagedObjectContext
    ) throws {
        let managedCache = try ManagedCache.fetchOrCreateCache(in: context)
        
        let existingTaskIDs = try ManagedTodoItem.fetchExistingTodoIDs(in: context)
        
        // Filter new tasks (skip existing tasks)
        let newTasks = tasks.filter {
            !existingTaskIDs.contains($0.id)
        }
        
        // Insert only new tasks into the cache
        if !newTasks.isEmpty {
            try managedCache.updateCache(with: newTasks, in: context)
            try context.save()
        }
    }
}

// MARK: - Updating
extension ManagedCache {
    static func update(
        _ item: LocalTodoItem,
        context: NSManagedObjectContext
    ) throws {
        // Fetch the task or throw an error
        guard let managedTodo = try ManagedTodoItem.first(with: item, in: context) else {
            throw CoreDataFeedStoreError.todoNotFound
        }
        
        // Update the managed task
        ManagedTodoItem.update(managedTodo, with: item)
        
        try context.save()
    }
}
