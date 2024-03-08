//
//  DataController.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/5.
//

import Foundation
import CoreData
import SwiftData

struct DataController {
    let appGroupContainerID = "group.com.DoubleShy0N.DaySnap"
    
    static let shared = DataController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        guard let modelURL = Bundle.main.url(forResource: "DaySnap", withExtension: "momd") else {
            fatalError("Unable to find DaySnap data model in the bundle.")
        }
        
        guard let coreDataModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to create the DaySnap Core Data model.")
        }
        
        container = NSPersistentContainer(name: "DaySnap", managedObjectModel: coreDataModel)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        } else {
            guard let appGroupContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupContainerID) else {
                fatalError("Shared file container could not be created.")
            }
            
            let url = appGroupContainer.appendingPathComponent("DaySnap.sqlite")
            
            if let description = container.persistentStoreDescriptions.first {
                description.url = url
                description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            }
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
//    func saveContext() {
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let NsError = error as NSError
//                fatalError("Unresolved error \(NsError), \(NsError.userInfo)")
//            }
//        }
//    }
}

public extension URL {
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Unable to create URL for \(appGroup)")
        }
        
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
