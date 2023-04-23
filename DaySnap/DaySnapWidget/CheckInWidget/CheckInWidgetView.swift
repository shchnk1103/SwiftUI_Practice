//
//  CheckInWidgetView.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/19.
//

import SwiftUI

struct CheckInWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: CheckInWidgetEntry
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallCheckInWidget(entry: entry)
        case .systemMedium:
            MediumCheckInWidget(entry: entry)
        case .accessoryInline:
            InlineCheckInWidget(entry: entry)
        case .accessoryCircular:
            CircularCheckInWidget(entry: entry)
        case .accessoryRectangular:
            RectangularCheckInWidget(entry: entry)
        default:
            Text("Unkown")
        }
    }
}
