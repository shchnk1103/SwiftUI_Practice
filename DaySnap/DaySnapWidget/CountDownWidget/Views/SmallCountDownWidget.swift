//
//  SmallCountDownWidget.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/19.
//

import SwiftUI

struct SmallCountDownWidget: View {
    @Environment(\.colorScheme) var colorScheme
    
    var entry: Provider.Entry
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 0) {
                if entry.countdowns.first?.remainingDays ?? 0 > 0 {
                    Text("距离 ")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Text(entry.countdowns.first?.name ?? "Test")
                    .lineLimit(1)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? Color.black.opacity(0.8) : Color.white.opacity(0.6))
                    .padding(.horizontal, 7)
                    .padding(.vertical, 2)
                    .background(colorScheme == .dark ? Color.white.opacity(0.6) : Color.black.opacity(0.8), in: Capsule())
                
                if entry.countdowns.first?.remainingDays ?? 0 < 0 {
                    Text(" 已经")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(String(abs(entry.countdowns.first?.remainingDays ?? 0)))
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(entry.date, style: .date)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ContainerRelativeShape().fill(.ultraThinMaterial))
        .shadow(color: colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.25), radius: 20, x: 6, y: 6)
        .padding()
    }
}
