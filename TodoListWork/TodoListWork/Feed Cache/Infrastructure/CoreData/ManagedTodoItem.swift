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
    
    static func createManagedTodoitem(
        from localTasks: [LocalTodoItem],
        in context: NSManagedObjectContext,
        cache: ManagedCache
    ) -> NSOrderedSet {
        let tasks = NSOrderedSet(array: localTasks.map { local in
            let managedTask = ManagedTodoItem(context: context)
            managedTask.id = local.id
            managedTask.title = local.title
            managedTask.descriptionText = local.description
            managedTask.createdAt = local.createdAt
            managedTask.completed = local.completed
            managedTask.userId = local.userId
            managedTask.cache = cache
            
            return managedTask
        })
        
        return tasks
    }
    
    static func fetchExistingTodoIDs(in context: NSManagedObjectContext) throws -> Set<UUID> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ManagedTodoItem.entity().name!)
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = ["id"]
        
        let results = try context.fetch(request) as? [[String: Any]]
        
        let ids = results?.compactMap { dict in
            // Extract UUID from dictionary using the key "id"
            dict["id"] as? UUID
        }
        
        return Set(ids ?? [])
    }
    
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
