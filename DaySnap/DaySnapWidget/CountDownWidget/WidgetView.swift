//
//  WidgetView.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/5.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallCountDownWidget(entry: entry)
        case .systemMedium:
            MediumCountDownWidget(entry: entry)
        case .accessoryCircular:
            CircularCountDownWidget(entry: entry)
        case .accessoryRectangular:
            RectangularCountDownWidget(entry: entry)
        case .accessoryInline:
            InlineCountDownWidget(entry: entry)
        default:
            Text("Unkown")
        }
    }
}
