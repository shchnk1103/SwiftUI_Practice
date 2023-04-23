//
//  InlineCountDownWidget.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/20.
//

import SwiftUI
import WidgetKit

struct InlineCountDownWidget: View {
    var entry: Provider.Entry
    
    var body: some View {
        let countdown = entry.countdowns.first
        let emoji = countdown?.emojiText ?? "❤️"
        let remainingDays = countdown?.remainingDays ?? 7
        let text = countdown?.remainingDays ?? 7 > 0 ? "还有 " : "已经 "
        
        let result = emoji + " " + text + String(remainingDays) + " 天"
        
        Text(result)
    }
}

struct InlineCountDownWidget_Previews: PreviewProvider {
    static var previews: some View {
        InlineCountDownWidget(entry: Provider.Entry(date: Date(), countdowns: []))
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
    }
}
