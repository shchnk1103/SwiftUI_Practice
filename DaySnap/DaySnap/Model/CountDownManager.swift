//
//  CountDownManager.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/5.
//

import Foundation
import CoreData

class CountDownManager {
    static let shared = CountDownManager()
    
    private init() {
        // 初始化管理器，进行所需的设置和配置
    }
    
    // 创建一个持久器容器属性
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DaySnap")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // 处理错误情况
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func calRemainingDays(targetDay: Date) -> Int32 {
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
    
    func initCountDown() -> CountDown? {
        let context = getContext()
        if let entity = NSEntityDescription.entity(forEntityName: "CountDown", in: context) {
            let countdown = CountDown(entity: entity, insertInto: context)
            return countdown
        }
        return nil
    }
    
    func createCountDown(countdown: CountDown) -> CountDown? {
        let context = getContext()
        if let entity = NSEntityDescription.entity(forEntityName: "CountDown", in: context) {
            let countDown = CountDown(entity: entity, insertInto: context)
            // 计算remainingDays
            let remainingDays = calRemainingDays(targetDay: countdown.targetDate!)
            
            countDown.id = UUID()
            countDown.emojiText = countdown.emojiText
            countDown.name = countdown.name
            countDown.targetDate = countdown.targetDate
            countDown.isPinned = countdown.isPinned
            countDown.isReminder = countdown.isReminder
            countDown.notificationDate = countdown.notificationDate
            countDown.remainingDays = remainingDays
            
            do {
                try context.save()
                return countDown
            } catch let error as NSError {
                // 处理错误情况
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        return nil
    }
    
    // 检索 CountDown 实体的所有记录
    func fetchAllCountDowns() -> [CountDown] {
        let context = getContext()

        let fetchRequest: NSFetchRequest<CountDown> = CountDown.fetchRequest()
        
        // 添加排序描述符
        let pinnedSortDescriptor = NSSortDescriptor(key: "isPinned", ascending: false)
        let remainingDaysSortDescriptor = NSSortDescriptor(key: "remainingDays", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [pinnedSortDescriptor, remainingDaysSortDescriptor, nameSortDescriptor]
        
        do {
            let countDowns = try context.fetch(fetchRequest)
            return countDowns
        } catch let error as NSError {
            // 处理错误情况
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return []
    }
    
    func delete(countDown: CountDown) {
        let context = getContext()
        context.delete(countDown)

        do {
            try context.save()
        } catch let error as NSError {
            // 处理错误情况
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func update(countdown: CountDown, newEmoji: String, newTitle: String, newTargetDate: Date, newIsPinned: Bool, newIsReminder: Bool, newNotificationDate: Date) {
        let context = getContext()
        countdown.name = newTitle
        countdown.emojiText = newEmoji
        countdown.isPinned = newIsPinned
        countdown.isReminder = newIsReminder
        countdown.notificationDate = newNotificationDate
        countdown.targetDate = newTargetDate
        countdown.remainingDays = calRemainingDays(targetDay: newTargetDate)
        
        do {
            try context.save()
        } catch {
            print("Error updating Countdown: \(error.localizedDescription)")
        }
    }
}
