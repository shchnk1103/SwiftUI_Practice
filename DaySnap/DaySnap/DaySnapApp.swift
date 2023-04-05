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
    
    // 声明通知管理器
    @StateObject var notificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(countdownStore)
                .environmentObject(checkinStore)
                .environmentObject(notificationManager)
//            test_1()
//                .environmentObject(notificationManager)
        }
    }
}
