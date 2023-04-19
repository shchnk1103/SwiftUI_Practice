//
//  WidgetView.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/5.
//

import SwiftUI

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
        default:
            Text("Unkown")
        }
    }
}
