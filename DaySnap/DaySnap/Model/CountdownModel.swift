//
//  CountdownModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/12.
//

import Foundation

struct Countdown: Codable, Identifiable, Hashable {
    var id = UUID()
    var emojiText: String
    var name: String
    var targetDate: Date
    var isPinned: Bool
    var isReminder: Bool
    var notificationDate: Date
    
    var remainingDays: Int? {
        let calendar = Calendar.current
        let today = Date() // 当前日期
        
        // 将日期分解为只包含day、month和year的组件
        let date1 = calendar.dateComponents([.day, .month, .year], from: today)
        let date2 = calendar.dateComponents([.day, .month, .year], from: targetDate)
        
        // 使用组件计算日期之间的时间差（天数）
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day
    }
    
    var remainingDaysBool: Bool {
        if remainingDays! < 0 {
            return false
        } else {
            return true
        }
    }
}

class CountdownStore: ObservableObject {
    fileprivate let userDefaults = UserDefaults.standard
    fileprivate let key = "countdowns"
    
    var countdowns: [Countdown] {
        get {
            if let data = userDefaults.data(forKey: key) {
                return decode(data: data)
            }
            return []
        }
        
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: key)
        }
    }
    
    func add(countdown: Countdown) {
        var countdowns = self.countdowns
        countdowns.append(countdown)
        self.countdowns = countdowns
    }
    
    func update(countdown: Countdown) {
        guard let index = self.countdowns.firstIndex(where: { $0.id == countdown.id }) else { return }
        self.countdowns[index] = countdown
    }
    
    func delete(countdown: Countdown) {
        var countdowns = self.countdowns
        if let index = countdowns.firstIndex(where: { $0.id == countdown.id }) {
            countdowns.remove(at: index)
            self.countdowns = countdowns
        }
    }
    
    fileprivate func decode(data: Data) -> [Countdown] {
        let countdowns = try? JSONDecoder().decode([Countdown].self, from: data)
        return countdowns ?? []
    }
}

extension Array where Element == Countdown {
    func sortedByPriority() -> [Countdown] {
        let pinnedCountdowns = self.filter { $0.isPinned }
        let unpinnedCountdowns = self.filter { !$0.isPinned }
        var sortedCountdowns = [Countdown]()
        
        sortedCountdowns.append(contentsOf: pinnedCountdowns.sorted(by: { countdown1, countdown2 in
            if countdown1.remainingDays! == countdown2.remainingDays! {
                return countdown1.name < countdown2.name
            }
            return countdown1.remainingDays! > countdown2.remainingDays!
        }))
        
        sortedCountdowns.append(contentsOf: unpinnedCountdowns.sorted(by: { countdown1, countdown2 in
            if countdown1.remainingDays! == countdown2.remainingDays! {
                return countdown1.name < countdown2.name
            }
            return countdown1.remainingDays! > countdown2.remainingDays!
        }))
        
        return sortedCountdowns
    }
}
