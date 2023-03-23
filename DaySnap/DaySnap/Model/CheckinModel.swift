//
//  CheckinModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/14.
//

import Foundation

struct Checkin: Codable, Identifiable, Hashable {
    var id = UUID()
    var emojiText: String
    var name: String
    var targetDate: String?
    var persistDay: Int = 0
    var isPinned: Bool
    var isReminder: Bool
    var notificationDate: Date?
}

class CheckinStore: ObservableObject {
    fileprivate let userDefaults = UserDefaults.standard
    fileprivate let key = "checkin"
    
    var checkins: [Checkin] {
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
    
    func add(checkin: Checkin) {
        var checkins = self.checkins
        checkins.append(checkin)
        self.checkins = checkins
    }
    
    func update(checkin: Checkin) {
        var checkins = self.checkins
        if let index = checkins.firstIndex(where: { $0.id == checkin.id }) {
            checkins[index] = checkin
            self.checkins = checkins
        }
    }
    
    func delete(checkin: Checkin) {
        var checkins = self.checkins
        if let index = checkins.firstIndex(where: { $0.id == checkin.id }) {
            checkins.remove(at: index)
            self.checkins = checkins
        }
    }
    
    fileprivate func decode(data: Data) -> [Checkin] {
        let checkins = try? JSONDecoder().decode([Checkin].self, from: data)
        return checkins ?? []
    }
}
