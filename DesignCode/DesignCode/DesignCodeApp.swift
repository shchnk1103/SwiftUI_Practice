//
//  DesignCodeApp.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/2.
//

import SwiftUI

@main
struct DesignCodeApp: App {
    @StateObject var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
