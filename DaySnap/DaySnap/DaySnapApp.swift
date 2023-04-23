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
struct DaySnapApp {
    static func main() {
        if #available(iOS 16.0, *) {
            New_iOSApp.main()
        } else {
            Old_iOSApp.main()
        }
    }
}

@available(iOS 16.0, *)
struct NewAppScene: Scene {
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
            await updateAboutCountDown()
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

@available(iOS 16.0, *)
struct New_iOSApp: App {
    var body: some Scene {
        NewAppScene()
    }
}

struct AppScene: Scene {
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
    }
    
    init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_WbrBpKtbIpFjxSIVtHtCyWkSzXO")
    }
}

struct Old_iOSApp: App {
    var body: some Scene {
        AppScene()
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
