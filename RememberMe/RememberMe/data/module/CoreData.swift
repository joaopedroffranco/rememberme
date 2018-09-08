//
//  CoreData.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 08/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RememberMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

protocol CoreDataModel { }
extension NSManagedObject: CoreDataModel { }
extension CoreDataModel where Self: NSManagedObject {
    static func get(fromContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext) -> Self? {
        let fullName = NSStringFromClass(self)
        if let entity = NSEntityDescription.entity(forEntityName: fullName, in: fromContext) {
            return Self(entity: entity, insertInto: fromContext)
        }
        
        return nil
    }
    
    static func fetch(fromContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext) -> [Self] {
        do {
            let response = try fromContext.fetch(Self.fetchRequest()) as! [Self]
            return response
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
