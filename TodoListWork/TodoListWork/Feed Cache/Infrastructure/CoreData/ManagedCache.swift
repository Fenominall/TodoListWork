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

        // Copy existing tasks from the feed
        let existingTasks = feed.mutableCopy() as? NSMutableOrderedSet ?? NSMutableOrderedSet()

        // Create new managed tasks and associate them with the cache
        let newTasks = ManagedTodoItem.createManagedTodoitem(from: tasks, in: context, cache: managedCache)
        
        // Add new tasks to the existing cache
        existingTasks.addObjects(from: newTasks.array)

        // Update the cache feed
        if let updatedCache = existingTasks.copy() as? NSOrderedSet {
            feed = updatedCache
        } else {
            throw CoreDataFeedStoreError.unableToCreateMutableCopy
        }
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
        guard let managedTask = try ManagedTodoItem.first(with: task, in: context) else {
            throw CoreDataFeedStoreError.todokNotFound
        }
        
        guard managedTask.id == task.id else {
            throw CoreDataFeedStoreError.todoIDMismatch
        }
        
        ManagedTodoItem.update(managedTask, with: task)
        
        do {
            try context.save()
        } catch {
            throw error
        }
    }
}
