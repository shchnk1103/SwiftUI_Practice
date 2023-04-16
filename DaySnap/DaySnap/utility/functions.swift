//
//  functions.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/6.
//

import Foundation
import CoreData

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

func updateRemainingDays() async {
    let request: NSFetchRequest<CountDown> = CountDown.fetchRequest()
    let context = PersistenceController.shared.container.viewContext

    do {
        let countdowns = try context.fetch(request)

        for countdown in countdowns {
            countdown.remainingDays = calRemainingDays(targetDay: countdown.targetDate ?? Date())
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

//func sortedByPriority() -> [Countdown] {
//    let pinnedCountdowns = self.filter { $0.isPinned }
//    let unpinnedCountdowns = self.filter { !$0.isPinned }
//
//    let sortedPinnedCountdowns = pinnedCountdowns.sorted { countdown1, countdown2 in
//        if countdown1.remainingDays >= 0 {
//            if countdown2.remainingDays >= 0 {
//                if countdown1.remainingDays == countdown2.remainingDays {
//                    return countdown1.name < countdown2.name
//                }
//                return countdown1.remainingDays < countdown2.remainingDays
//            } else {
//                // countdown1.remainingDays >= 0 && countdown2.remainingDays < 0
//                return true
//            }
//        } else {
//            if countdown2.remainingDays < 0 {
//                if countdown1.remainingDays == countdown2.remainingDays {
//                    return countdown1.name < countdown2.name
//                }
//                return countdown1.remainingDays < countdown2.remainingDays
//            } else {
//                // countdown1.remainingDays < 0 && countdown2.remainingDays >= 0
//                return false
//            }
//        }
//    }
//
//    let sortedUnpinnedCountdowns = unpinnedCountdowns.sorted { countdown1, countdown2 in
//        if countdown1.remainingDays >= 0 {
//            if countdown2.remainingDays >= 0 {
//                if countdown1.remainingDays == countdown2.remainingDays {
//                    return countdown1.name < countdown2.name
//                }
//                return countdown1.remainingDays < countdown2.remainingDays
//            } else {
//                // countdown1.remainingDays >= 0 && countdown2.remainingDays < 0
//                return true
//            }
//        } else {
//            if countdown2.remainingDays < 0 {
//                if countdown1.remainingDays == countdown2.remainingDays {
//                    return countdown1.name < countdown2.name
//                }
//                return countdown1.remainingDays < countdown2.remainingDays
//            } else {
//                // countdown1.remainingDays < 0 && countdown2.remainingDays >= 0
//                return false
//            }
//        }
//    }
//
//    return sortedPinnedCountdowns + sortedUnpinnedCountdowns
//}
