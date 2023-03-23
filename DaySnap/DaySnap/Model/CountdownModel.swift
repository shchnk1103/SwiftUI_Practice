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
        var countdowns = self.countdowns
        if let index = countdowns.firstIndex(where: { $0.id == countdown.id }) {
            countdowns[index] = countdown
            self.countdowns = countdowns
        }
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
