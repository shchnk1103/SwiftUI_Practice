//
//  RectangularCountDownWidget.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/20.
//

import SwiftUI
import WidgetKit

struct RectangularCountDownWidget: View {
    var entry: Provider.Entry
    
    var body: some View {
        let countdown = entry.countdowns.first
        
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center, spacing: 5) {
                Text("\(countdown?.emojiText ?? "❤️")")
                
                Text("\(countdown?.name ?? "Love")")
                    .font(.headline)
            }
            
            HStack(spacing: 5) {
                Text("\(countdown?.remainingDays ?? 7 > 0 ? "还有" : "已经")")
                
                Text("\(countdown?.remainingDays ?? 7)")
                    .font(.headline)
                
                Text("天")
            }
            .font(.caption)
        }
    }
}

struct RectangularCountDownWidget_Previews: PreviewProvider {
    static var previews: some View {
        RectangularCountDownWidget(entry: Provider.Entry(date: Date(), countdowns: []))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
