//
//  PreviewSampleData.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2024/1/4.
//

import Foundation
import SwiftData

/**
 Preview sample data.
 */
actor PreviewSampleData {
    
    @MainActor
    static var container: ModelContainer = {
        return try! inMemoryContainer()
    }()
    
    static var inMemoryContainer: () throws -> ModelContainer = {
        let schema = Schema([SDCountDown.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        let sampleData: [any PersistentModel] = [
            SDCountDown.preview
        ]
        Task { @MainActor in
            sampleData.forEach {
                container.mainContext.insert($0)
            }
        }
        return container
    }
}
