//
//  InlineCheckInWidget.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/20.
//

import SwiftUI
import WidgetKit

struct InlineCheckInWidget: View {
    var entry: CheckInWidgetEntry
    
    var body: some View {
        let count = entry.checkins.filter({ !$0.isCheckin }).count
        
        Text(count > 0 ? "还有 \(count) 个未打卡" : "已完成今日打卡")
    }
}

struct InlineCheckInWidget_Previews: PreviewProvider {
    static var previews: some View {
        InlineCheckInWidget(entry: CheckInWidgetEntry(date: Date(), checkins: []))
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
    }
}
