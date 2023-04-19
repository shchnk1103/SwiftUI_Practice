//
//  CheckInWidget.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/19.
//

import WidgetKit
import SwiftUI

struct CheckInWidget: Widget {
    let kind: String = "CheckInWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CheckInWidgetProvider(dataController: DataController())) { entry in
            CheckInWidgetView(entry: entry)
        }
        .configurationDisplayName("不知道数日 - 打卡")
        .description("这是打卡的小组件")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct CheckInWidget_Previews: PreviewProvider {
    static var previews: some View {
        CheckInWidgetView(entry: CheckInWidgetEntry(date: Date(), checkins: []))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
