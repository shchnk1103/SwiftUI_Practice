//
//  MediumCountDownWidget.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/19.
//

import SwiftUI

struct MediumCountDownWidget: View {
    @Environment(\.colorScheme) var colorScheme
    
    var entry: Provider.Entry
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(
                        colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5),
                        lineWidth: 1
                    )
                    .frame(width: 60, height: 60)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .overlay {
                        Text(entry.countdowns.first?.emojiText ?? "🥰")
                            .font(.largeTitle)
                    }
                    .padding(10)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text(entry.countdowns.first?.remainingDays == 0 ? "" : "距离 ")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        if entry.countdowns.first?.remainingDays == 0 {
                            Image(systemName: "laurel.leading")
                                .fontWeight(.semibold)
                                .padding(.trailing, 3)
                            
                            Text(entry.countdowns.first?.name ?? "")
                                .font(.body)
                            
                            Image(systemName: "laurel.trailing")
                                .fontWeight(.semibold)
                                .padding(.leading, 3)
                        } else {
                            Text(entry.countdowns.first?.name ?? "")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .dark ? Color.black.opacity(0.8) : Color.white.opacity(0.6))
                                .padding(.horizontal, 7)
                                .padding(.vertical, 2)
                                .background(colorScheme == .dark ? Color.white.opacity(0.6) : Color.black.opacity(0.8), in: Capsule())
                        }
                    }
                    
                    HStack(spacing: 0) {
                        Text(entry.countdowns.first?.remainingDays ?? 0 > 0
                             ? "还有 "
                             : (entry.countdowns.first?.remainingDays == 0 ? "就是今天" : "已经 ")
                        )
                        .font(.body)
                        .foregroundColor(.secondary)
                        
                        if entry.countdowns.first?.remainingDays != 0 {
                            Text(String(abs(entry.countdowns.first?.remainingDays ?? 0)))
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text(" 天")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "ellipsis.circle")
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding(.trailing)
            }
            
            HStack {
                Text("目标日期：")
                
                Text(entry.countdowns.first?.targetDate ?? Date(), style: .date)
                    .fontWeight(.semibold)
            }
            .font(.title3)
            .foregroundColor(colorScheme == .dark ? Color.black.opacity(0.8) : Color.white.opacity(0.6))
            .padding(.horizontal, 7)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(colorScheme == .dark ? Color.white.opacity(0.6) : Color.black.opacity(0.8), in: Capsule())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
