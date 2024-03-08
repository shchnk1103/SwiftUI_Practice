//
//  ElasticSegmentedControlApp.swift
//  ElasticSegmentedControl
//
//  Created by DoubleShy0N on 2024/3/8.
//

import SwiftUI
import SwiftData

@main
struct ElasticSegmentedControlApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
