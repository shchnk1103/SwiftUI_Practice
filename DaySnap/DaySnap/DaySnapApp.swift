//
//  DaySnapApp.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI
import BackgroundTasks
import RevenueCat

@main
struct DaySnapApp: App {
    // 声明通知管理器
    @StateObject var notificationManager = NotificationManager()
    
    @StateObject private var dataController = DataController()
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
                .environmentObject(userViewModel)
                .environment(\.managedObjectContext, dataController.context)
        }
        .backgroundTask(.appRefresh("CountdownZero")) {
            countdownRemainningDaysRefresh()
            await updateRemainingDays()
        }
        .backgroundTask(.appRefresh("CheckinZero")) {
            isCheckinRefresh()
            await updateIsCheckin()
        }
    }
    
    init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_WbrBpKtbIpFjxSIVtHtCyWkSzXO")
    }
}

// 后台任务
func countdownRemainningDaysRefresh() {
    let today = Calendar.current.startOfDay(for: .now)
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
    let zeroComponent = DateComponents(hour: 0)
    let zero = Calendar.current.date(byAdding: zeroComponent, to: tomorrow)
    
    let request = BGAppRefreshTaskRequest(identifier: "CountdownZero")
    request.earliestBeginDate = zero
    try? BGTaskScheduler.shared.submit(request)
}

func isCheckinRefresh() {
    let today = Calendar.current.startOfDay(for: .now)
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
    let zereComponent = DateComponents(hour: 0)
    let zero = Calendar.current.date(byAdding: zereComponent, to: tomorrow)
    
    let request = BGAppRefreshTaskRequest(identifier: "CheckinZero")
    request.earliestBeginDate = zero
    try? BGTaskScheduler.shared.submit(request)
}
