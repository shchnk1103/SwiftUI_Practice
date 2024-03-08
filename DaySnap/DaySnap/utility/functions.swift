//
//  functions.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/6.
//

import Foundation
import CoreData
import SwiftUI

func calRemainingDays(targetDay: Date) -> Int32 {
    let calendar = Calendar.current
    let today = Date() // 当前日期
    
    // 将日期分解为只包含day、month和year的组件
    let date1 = calendar.dateComponents([.day, .month, .year], from: today)
    let date2 = calendar.dateComponents([.day, .month, .year], from: targetDay)
    
    // 使用组件计算日期之间的时间差（天数）
    let components = calendar.dateComponents([.day], from: date1, to: date2)
    
    guard let days = components.day else {
        return 0
    }
    
    return Int32(days)
}

func updateAboutCountDown() async {
    let request: NSFetchRequest<CountDown> = CountDown.fetchRequest()
    let context = PersistenceController.shared.container.viewContext

    do {
        let countdowns = try context.fetch(request)
        let notificationManager = NotificationManager()
        let currentDate = Date()

        for countdown in countdowns {
            // 计算距离目标日还有多远
            countdown.remainingDays = calRemainingDays(targetDay: countdown.targetDate ?? Date())
            
            // *** 通知 ***
            // 计算得出下一次通知日
            var nextNotificationDate = calNextNotificationTime(selectedReminder: Int(countdown.reminderEvent))
            // 如果下一次通知日在目标日之后
            if nextNotificationDate > countdown.targetDate ?? Date() {
                // 那么就直接在目标日通知
                nextNotificationDate = countdown.targetDate ?? Date()
                countdown.notificationDate = countdown.targetDate ?? Date()
            } else {
                // 如果通知日就是今天，那么就在中午12点发送通知
                if Calendar.current.isDate(countdown.notificationDate ?? Date(), inSameDayAs: currentDate) {
                    notificationManager.sendNotification(countdown: countdown, identifier: countdown.id?.uuidString ?? UUID().uuidString)
                    // 记录下一次通知的日期
                    countdown.notificationDate = nextNotificationDate
                }
            }
        }

        try context.save()

    } catch let error as NSError {
        print("Could not fetch countdown. \(error), \(error.userInfo)")
    }
}

func updateIsCheckin() async {
    let request: NSFetchRequest<CheckIn> = CheckIn.fetchRequest()
    let context = PersistenceController.shared.container.viewContext
    
    do {
        let checkins = try context.fetch(request)
        
        for checkin in checkins {
            checkin.isCheckin = false
        }
        
        try context.save()
    } catch let error as NSError {
        print("Could not fetch checkin. \(error), \(error.userInfo)")
    }
}

// MARK: 检查每个CheckIn是否可以点击
// 检查是否可以点击 Check In 按钮
func canCheckin(checkin: CheckIn) -> Bool {
    guard let lastCheckinTime = checkin.lastCheckinTime else { return true }
    
    let calendar = Calendar.current
    let today = Date()
    
    let lastCheckinDay = calendar.component(.day, from: lastCheckinTime)
    let todayDay = calendar.component(.day, from: today)
    
    return todayDay != lastCheckinDay
}

// 计算下一次需要通知的时间
func calNextNotificationTime(selectedReminder: Int) -> Date {
    let date = Date()
    switch selectedReminder {
    case 0:
        return Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
    case 1:
        return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date) ?? Date()
    case 2:
        return Calendar.current.date(byAdding: .month, value: 1, to: date) ?? Date()
    case 3:
        return Calendar.current.date(byAdding: .year, value: 1, to: date) ?? Date()
    default:
        return date
    }
}

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DaySnap")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

func colorToString(color: Color) -> String {
    let uiColor = UIColor(color)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    return "\(red),\(green),\(blue),\(alpha)"
}

func stringToColor(color: String) -> Color {
    let color = color.components(separatedBy: ",")
    if let red = Double(color[0]),
       let green = Double(color[1]),
       let blue = Double(color[2]),
       let alpha = Double(color[3]) {
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
    return Color.primary
}
