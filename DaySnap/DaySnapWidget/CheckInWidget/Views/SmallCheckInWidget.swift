//
//  SmallCheckInView.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/19.
//

import SwiftUI

struct SmallCheckInWidget: View {
    @Environment(\.colorScheme) var colorScheme
    
    var entry: CheckInWidgetEntry
    
    var body: some View {
        let checkinsCount = entry.checkins.filter({ $0.isCheckin }).count
        let progress = Double(checkinsCount) / Double(entry.checkins.count)
        
        ZStack {
            Circle()
                .stroke(lineWidth: 12.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.black.opacity(0.8))
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
                
            VStack {
                if progress == 1.0 {
                    Text("已完成")
                } else {
                    Text("打卡进度")
                }
            }
            .lineLimit(1)
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(colorScheme == .dark ? .black : .white.opacity(0.8))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(colorScheme == .dark ? Color.white.opacity(0.6) : Color.black.opacity(0.8), in: Capsule())
        }
        .padding()
    }
}

