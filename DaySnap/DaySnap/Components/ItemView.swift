//
//  ItemView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var checkinStore: CheckinStore
    @EnvironmentObject var countdownStore: CountdownStore
    @Binding var flag: Bool
    var id: UUID
    private var countdown: Countdown? {
        countdownStore.countdowns.filter({ $0.id == id }).first ?? nil
    }
    private var checkin: Checkin? {
        checkinStore.checkins.filter({ $0.id == id }).first ?? nil
    }
    
    var body: some View {
        HStack {
            roundedRectangle
            
            content
            
            Spacer()
            
            Image(systemName: "ellipsis.circle")
                .font(.title)
                .foregroundColor(.secondary)
                .padding(.trailing)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(colorScheme == .dark ? .white.opacity(0.6) : .gray.opacity(0.5), lineWidth: 1)
                .shadow(color: colorScheme == .dark ? .white : .gray, radius: 8, x: 0, y: 0)
        }
    }
    
    var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(
                colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5),
                lineWidth: 1
            )
            .frame(width: 60, height: 60)
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .overlay {
                Text((flag ? countdown?.emojiText : checkin?.emojiText) ?? "🥰")
                    .font(.largeTitle)
            }
            .padding(10)
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(flag ? "距离" : "坚持")
                    .font(.body)
                    .foregroundColor(.secondary)
                Text((flag
                      ? countdown?.name ?? ""
                      : checkin?.name ?? "")
                )
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            
            HStack(alignment: .center, spacing: 0) {
                Text(flag ? "还有 " : "已经 ")
                    .font(.body)
                    .foregroundColor(.secondary)
                Text(flag
                     ? "\(daysUntilDate(countdown?.targetDate ?? Date()) ?? 0)"
                     : "\(checkin?.persistDay ?? 0)/\(checkin?.targetDate ?? "")")
                    .font(.title)
                    .fontWeight(.semibold)
                Text(" 天")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    func daysUntilDate(_ targetDate: Date) -> Int? {
        let calendar = Calendar.current
        let today = Date() // 当前日期
        
        // 将日期分解为只包含day、month和year的组件
        let date1 = calendar.dateComponents([.day, .month, .year], from: today)
        let date2 = calendar.dateComponents([.day, .month, .year], from: targetDate)
        
        // 使用组件计算日期之间的时间差（天数）
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day
    }
}

struct ItemView_Previews: PreviewProvider {
    static let checkinStore = CheckinStore()
    static let countdownStore = CountdownStore()
    
    static var previews: some View {
        ItemView(flag: .constant(false), id: UUID())
            .environmentObject(checkinStore)
            .environmentObject(countdownStore)
    }
}
