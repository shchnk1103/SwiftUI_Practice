//
//  DataController.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/5.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let persistentContainer: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "DaySnap")
        let url = URL.storeURL(for: "group.com.DoubleShy0N.DaySnap", databaseName: "DaySnap")
        let storeDescription = NSPersistentStoreDescription(url: url)
        persistentContainer.persistentStoreDescriptions = [storeDescription]
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        context.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() {
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

public extension URL {
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileCotainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Unable to create URL for \(appGroup)")
        }
        
        return fileCotainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
