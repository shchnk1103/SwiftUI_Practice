//
//  DaySnapApp.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI
import BackgroundTasks

@main
struct DaySnapApp: App {
    // 声明通知管理器
    @StateObject var notificationManager = NotificationManager()
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        .backgroundTask(.appRefresh("CountdownZero")) {
            scheduleAppRefresh()
            await updateRemainingDays()
        }
    }
}

func scheduleAppRefresh() {
    let today = Calendar.current.startOfDay(for: .now)
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
    let zeroComponent = DateComponents(hour: 0)
    let zero = Calendar.current.date(byAdding: zeroComponent, to: tomorrow)
    
    let request = BGAppRefreshTaskRequest(identifier: "CountdownZero")
    request.earliestBeginDate = zero
    try? BGTaskScheduler.shared.submit(request)
}
