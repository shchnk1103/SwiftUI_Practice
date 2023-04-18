//
//  ReminderModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/17.
//

import Foundation

struct Reminder: Identifiable, Hashable {
    var id: Int
    var name: String
}

var reminders = [
    Reminder(id: 0, name: "每天提醒"),
    Reminder(id: 1, name: "每周提醒"),
    Reminder(id: 2, name: "每月提醒"),
    Reminder(id: 3, name: "每年提醒")
]
