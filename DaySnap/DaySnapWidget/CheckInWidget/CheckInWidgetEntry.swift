//
//  CheckInWidgetEntry.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/19.
//

import SwiftUI
import WidgetKit

struct CheckInWidgetEntry: TimelineEntry {
    let date: Date
    let checkins: [CheckIn]
}
