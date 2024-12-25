//
//  ManagedTodoItem.swift
//  TodoListWork
//
//  Created by Fenominall on 12/10/24.
//

import Foundation
import CoreData

final class ManagedTodoItem: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var title: String
    @NSManaged var descriptionText: String?
    @NSManaged var completed: Bool
    @NSManaged var createdAt: Date
    @NSManaged var userId: Int
    @NSManaged var cache: ManagedCache?
}

// MARK: - Retririeving helpers
extension ManagedTodoItem {
    var local: LocalTodoItem? {
        return LocalTodoItem(
            id: id,
            title: title,
            description: descriptionText,
            completed: completed,
            createdAt: createdAt,
            userId: userId
        )
    }
}

// MARK: - Insertion Helpers
extension ManagedTodoItem {
    static func createBatch(
        from localTasks: [LocalTodoItem],
        in context: NSManagedObjectContext,
        with cache: ManagedCache
    ) -> [ManagedTodoItem] {
        return  localTasks.map { local in
            let managedTodo = ManagedTodoItem(context: context)
            managedTodo.id = local.id
            managedTodo.title = local.title
            managedTodo.descriptionText = local.description
            managedTodo.createdAt = local.createdAt
            managedTodo.completed = local.completed
            managedTodo.userId = local.userId
            managedTodo.cache = cache
            
            return managedTodo
        }
    }
    
    /// The function fetches all id values from the ManagedTodoItem entity in a highly optimized way
    /// It retrieves only the id field (not the full objects).
    /// It avoids duplicates by returning a Set<UUID>.
    static func fetchExistingTodoIDs(in context: NSManagedObjectContext) throws -> Set<UUID> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ManagedTodoItem.entity().name!)
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = ["id"]
        
        // as? [[String: Any]]:
        //        The result of context.fetch is cast to an optional array of dictionaries ([[String: Any]]).
        //        Each dictionary represents a fetched row where the keys are property names (like "id") and values are the corresponding data.
        
        let results = try context.fetch(request) as? [[String: Any]]
        
        // dict["id"] as? UUID attempts to cast the value to UUID. If the cast fails (e.g., the value is not a UUID), it is ignored.
        let ids = results?.compactMap { $0["id"] as? UUID }
        
        return Set(ids ?? [])
    }
}

// MARK: - Updation helpers
extension ManagedTodoItem {
    static func first(
        with localTodoItem: LocalTodoItem,
        in context: NSManagedObjectContext
    ) throws -> ManagedTodoItem? {
        let request = NSFetchRequest<ManagedTodoItem>(
            entityName: ManagedTodoItem.entity().name!
        )
        
        let uuidPredicate = NSPredicate(
            format: "id == %@",
            localTodoItem.id as CVarArg
        )
        
        request.predicate = uuidPredicate
        request.returnsObjectsAsFaults = true
        request.fetchLimit = 1
        
        return try context.fetch(request).first
    }
    
    static func update(
        _ managedTodo: ManagedTodoItem,
        with task: LocalTodoItem
    ) {
        managedTodo.id = task.id
        managedTodo.title = task.title
        managedTodo.descriptionText = task.description
        managedTodo.createdAt = task.createdAt
        managedTodo.completed = task.completed
        managedTodo.userId = task.userId
    }
}

// MARK: - Deletion helpers
extension ManagedTodoItem {
    static func delete(
        _ item: LocalTodoItem,
        in context: NSManagedObjectContext
    ) throws {
        // Find the task to delete
        guard let managedTodo = try ManagedTodoItem.first(with: item, in: context) else {
            throw CoreDataFeedStoreError.todoNotFound
        }
        
        // Attempt to update the cache and remove the task
        try removeFromCache(managedTodo, in: context)
        
        // Delete the task from Core Data context
        context.delete(managedTodo)
        
        // Save the context
        try context.save()
    }
    
    private static func removeFromCache(
        _ item: ManagedTodoItem,
        in context: NSManagedObjectContext
    ) throws {
        guard let cache = try ManagedCache.find(in: context) else {
            throw CoreDataFeedStoreError.missingManagedObjectContext
        }
        
        guard let mutableFeed = cache.feed.mutableCopy() as? NSMutableOrderedSet else {
            throw CoreDataFeedStoreError.unableToCreateMutableCopy
        }
        
        // Remove the task
        mutableFeed.remove(item)
        
        // Update the feed
        cache.feed = mutableFeed.copy() as? NSOrderedSet ?? NSOrderedSet()
    }
}

// MARK: - Search
extension ManagedTodoItem {
    static func findBy(
        _ query: String,
        in context: NSManagedObjectContext
    ) throws -> [ManagedTodoItem] {
        let request = NSFetchRequest<ManagedTodoItem>(
            entityName: ManagedTodoItem.entity().name!
        )
        
        // Preprocess the query to allow flexible matching
        let wildcardQuery = "*" + query.replacingOccurrences(of: " ", with: "*") + "*"
        
        // Create a predicate to search within the title and descriptionText fields
        let predicate = NSPredicate(
            format: "title LIKE[cd] %@ OR descriptionText LIKE[cd] %@",
            wildcardQuery, wildcardQuery
        )
        
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        
        return try context.fetch(request)
    }
}
