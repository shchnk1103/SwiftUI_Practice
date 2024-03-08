//
//  CountDown.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2024/1/4.
//
//

import Foundation
import SwiftData
import SwiftUI


@Model final class SDCountDown {
    var category: String
    var emojiText: String
    var id: UUID
    var isPinned: Bool
    var isReminder: Bool
    var name: String
    var notificationDate: Date?
    var remainingDays: Int32
    var reminderEvent: Int16
    var targetDate: Date
    
    init(name: String, emojiText: String, targetDate: Date = .distantFuture, category: String, id: UUID, isPinned: Bool, isReminder: Bool, remainingDays: Int32, reminderEvent: Int16) {
        self.name = name
        self.emojiText = emojiText
        self.targetDate = targetDate
        self.category = category
        self.id = id
        self.isPinned = isPinned
        self.isReminder = isReminder
        self.remainingDays = remainingDays
        self.reminderEvent = reminderEvent
    }
}

extension SDCountDown {
    static var preview: SDCountDown {
        let countdown = SDCountDown(name: "Test", emojiText: "🥰", targetDate: .distantFuture, category: "test", id: UUID.init(), isPinned: false, isReminder: false, remainingDays: 3, reminderEvent: 1)
        
        return countdown
    }
}
