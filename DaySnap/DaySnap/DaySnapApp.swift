//
//  DaySnapApp.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

@main
struct DaySnapApp: App {
    let countdownStore = CountdownStore()
    let checkinStore = CheckinStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(countdownStore)
                .environmentObject(checkinStore)
        }
    }
}
