//
//  CheckIn.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2024/1/4.
//
//

import Foundation
import SwiftData


@Model public class CheckIn {
    var emojiText: String?
    var id: UUID?
    var isCheckin: Bool?
    var isPinned: Bool?
    var isReminder: Bool?
    var lastCheckinTime: Date?
    var name: String?
    var notificationDate: Date?
    var persistDay: Int32? = 0
    var reminderEvent: Int16? = 0
    var targetDate: String?
    public init() {

    }
    
}
