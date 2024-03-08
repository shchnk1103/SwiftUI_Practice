//
//  Task_Management_AppApp.swift
//  Task Management App
//
//  Created by DoubleShy0N on 2023/7/20.
//

import SwiftUI
import SwiftData

@main
struct Task_Management_App: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
