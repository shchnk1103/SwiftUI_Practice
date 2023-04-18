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
    
    func sendNotification(countdown: CountDown, identifier: String) {
        // 创建通知的内容
        var title = ""
        if countdown.remainingDays > 0 {
            title = "\(String(describing: countdown.emojiText)) \(String(describing: countdown.name)) 还有\(countdown.remainingDays)天"
        } else if countdown.remainingDays == 0 {
            title = "\(String(describing: countdown.emojiText)) \(String(describing: countdown.name)) 就是今天"
        }
        let content = UNMutableNotificationContent()
        content.title = title
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        // 设置触发器，在指定日期的那一天中午12点发送通知
        let calendar = Calendar.current
        let noon = DateComponents(hour: 12, minute: 0)
        let components = calendar.dateComponents([.year, .month, .day], from: countdown.targetDate ?? Date())
        var triggerDate = calendar.date(from: components)!
        triggerDate = calendar.nextDate(after: triggerDate, matching: noon, matchingPolicy: .nextTime)!

        let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate), repeats: false)
        
        // 创建通知请求
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
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
    func scheduleNotificationsForDays(identifier: String, content: UNMutableNotificationContent, triggerDate: DateComponents, days: Int, reminderEvent: Int) {
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .day, value: days, to: Date())
        var interval = DateComponents(day: 1)
        
        switch reminderEvent {
        case 1:
            interval = DateComponents(weekOfYear: 1)
        case 2:
            interval = DateComponents(month: 1)
        case 3:
            interval = DateComponents(year: 1)
        default:
            break
        }
        
        var currentDate = Date()

        while currentDate <= endDate! {
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false))
            UNUserNotificationCenter.current().add(request)
            currentDate = calendar.date(byAdding: interval, to: currentDate)!
        }
    }
    
    func scheduleRepeatingNotificationForCheckin(title: String, persisDays: String, identifier: String, reminderEvent: Int) {
        let content = setupNotificationContent(title: title)
        let triggerDate = prepareTriggerDate()
        scheduleNotificationsForDays(identifier: identifier, content: content, triggerDate: triggerDate, days: Int(persisDays)!, reminderEvent: reminderEvent)
    }
    
    // 获取通知历史记录
    func getNotificationHistory() {
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    
    // 删除对应的通知
    func deleteNotification(identifier: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        let identifiers = [identifier]
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
        notificationCenter.removeDeliveredNotifications(withIdentifiers: identifiers)
    }
}
