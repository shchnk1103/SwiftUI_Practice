//
//  CircularCountDownWidget.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/20.
//

import SwiftUI
import WidgetKit

struct CircularCountDownWidget: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("\(entry.countdowns.first?.emojiText ?? "❤️")")
                .font(.largeTitle)
        }
    }
}

struct CircularCountDownWidget_Previews: PreviewProvider {
    static var previews: some View {
        CircularCountDownWidget(entry: Provider.Entry(date: Date(), countdowns: []))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
