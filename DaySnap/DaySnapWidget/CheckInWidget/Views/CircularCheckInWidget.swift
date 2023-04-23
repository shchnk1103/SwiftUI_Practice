//
//  CircularCheckInWidget.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/20.
//

import SwiftUI
import WidgetKit

struct CircularCheckInWidget: View {
    var entry: CheckInWidgetEntry
    
    var body: some View {
        let checkinsCount = entry.checkins.filter({ $0.isCheckin }).count
        let progress = Double(checkinsCount) / Double(entry.checkins.count)
        
        ZStack {
            Circle()
                .stroke(lineWidth: 8.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
            
            Image("icon")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .mask {
                    Circle()
                }
        }
        .frame(width: 40, height: 40)
    }
}

struct CircularCheckInWidget_Previews: PreviewProvider {
    static var previews: some View {
        CircularCheckInWidget(entry: CheckInWidgetEntry(date: Date(), checkins: []))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
