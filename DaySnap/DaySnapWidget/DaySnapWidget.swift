//
//  DaySnapWidget.swift
//  DaySnapWidget
//
//  Created by DoubleShy0N on 2023/4/3.
//

import WidgetKit
import SwiftUI

struct DaySnapWidget: Widget {
    let kind: String = "DaySnapWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(entry: entry)
        }
        .configurationDisplayName("DaySnap")
        .description("This is a widget about DaySnap.")
    }
}

struct DaySnapWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
