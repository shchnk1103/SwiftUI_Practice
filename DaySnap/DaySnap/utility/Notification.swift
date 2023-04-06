//
//  Notification.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/4.
//

import SwiftUI
import UserNotifications

class NotificationManager: ObservableObject {
    // 用于存储历史通知的数组
    @Published var notifications: [UNNotification] = []
    
    // 请求用户授权
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success && error == nil {
                print("用户授权成功")
            }
        }
    }
    
    func sendNotification(title: String, date: Date) {
        // 创建通知的内容
        let content = UNMutableNotificationContent()
        content.title = title
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        // 设置触发器，在指定日期和时间的那一天中午12点发送通知
        let calendar = Calendar.current
        let noon = DateComponents(hour: 12, minute: 0)
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        var triggerDate = calendar.date(from: components)!
        triggerDate = calendar.nextDate(after: triggerDate, matching: noon, matchingPolicy: .nextTime)!

        let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.year, .month, .day, .hour, .second], from: triggerDate), repeats: false)
        
        // 创建通知请求
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // 发送通知
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("通知预定成功")
            } else {
                print("通知预定失败")
            }
        }
    }
    
    // 设置通知内容
    func setupNotificationContent(title: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "别忘记你的每日打卡啦！"
        content.subtitle = title
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        return content
    }
    
    // 准备通知触发时间
    func prepareTriggerDate() -> DateComponents {
        let triggerDate = Date().addingTimeInterval(60 * 60 * 20) // 今天 20 点
        
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
    }
    
    // 根据指定的天数设置通知
    func scheduleNotificationsForDays(content: UNMutableNotificationContent, triggerDate: DateComponents, days: Int) {
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .day, value: days, to: Date())
        let interval = DateComponents(day: 1)
        var currentDate = Date()

        while currentDate <= endDate! {
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false))
            UNUserNotificationCenter.current().add(request)
            currentDate = calendar.date(byAdding: interval, to: currentDate)!
        }
    }
    
    func scheduleRepeatingNotificationForCheckin(title: String, persisDays: String) {
        let content = setupNotificationContent(title: title)
        let triggerDate = prepareTriggerDate()
        scheduleNotificationsForDays(content: content, triggerDate: triggerDate, days: Int(persisDays)!)
    }
    
    func getNotificationHistory() {
        // 获取通知历史记录
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
}
