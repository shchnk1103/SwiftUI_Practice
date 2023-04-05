//
//  DataController.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/5.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DaySnap")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
