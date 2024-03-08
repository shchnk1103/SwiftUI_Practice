//
//  Task.swift
//  Task Management App
//
//  Created by DoubleShy0N on 2023/7/20.
//

import SwiftUI
import SwiftData

@Model
class Task: Identifiable {
    var id: UUID
    var taskTitle: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: String
    
    init(id: UUID = .init(), taskTitle: String, creationDate: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
    
    var tintColor: Color {
        switch tint {
        case "TaskColor1":
            return Color.yellow
        case "TaskColor2":
            return Color.blue
        case "TaskColor3":
            return Color.white
        case "TaskColor4":
            return Color.pink
        case "TaskColor5":
            return Color.gray
        default:
            return Color.black
        }
    }
}

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
