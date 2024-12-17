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
    var localTodoTasksFeed: [LocalTodoItem] {
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
        with tasks: [LocalTodoItem],
        in context: NSManagedObjectContext
    ) throws {
        let managedCache = try ManagedCache.fetchOrCreateCache(in: context)
        
        // Get existing tasks to avoid duplicates
        let existingTasks = feed.mutableCopy() as? NSMutableOrderedSet ?? NSMutableOrderedSet()
        
        // Filter and add only new tasks
        let newTasks = ManagedTodoItem.createBatch(from: tasks, in: context, cache: managedCache)
        addTasksToCache(existingTasks, newTasks: newTasks)
        
        // Safely update the cache feed
        guard let updatedCache = existingTasks.copy() as? NSOrderedSet else {
            throw CoreDataFeedStoreError.missingManagedObjectContext
        }
        feed = updatedCache
    }
    
    private func addTasksToCache(
        _ existingTasks: NSMutableOrderedSet,
        newTasks: [ManagedTodoItem]
    ) {
        existingTasks.addObjects(from: newTasks)
    }
    
    static func insertTasks(
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
    static func updateTask(
        _ task: LocalTodoItem,
        context: NSManagedObjectContext
    ) throws {
        // Fetch the task or throw an error
        guard let managedTask = try ManagedTodoItem.first(with: task, in: context) else {
            throw CoreDataFeedStoreError.todokNotFound
        }
        
        // Update the managed task
        ManagedTodoItem.update(managedTask, with: task)
        
        try context.save()
    }
}
