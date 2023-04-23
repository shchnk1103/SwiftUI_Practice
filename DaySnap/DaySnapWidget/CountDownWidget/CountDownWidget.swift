//
//  DaySnapWidget.swift
//  DaySnapWidget
//
//  Created by DoubleShy0N on 2023/4/3.
//

import WidgetKit
import SwiftUI

struct CountDownWidget: Widget {
    let kind: String = "CountDownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(dataController: DataController())) { entry in
            WidgetView(entry: entry)
        }
        .configurationDisplayName("不知道数日 - 打卡")
        .description("这是倒数日的小组件")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryCircular, .accessoryRectangular, .accessoryInline])
    }
}

struct CountDownWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(entry: SimpleEntry(date: Date(), countdowns: []))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
