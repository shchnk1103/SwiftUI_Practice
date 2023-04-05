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
    @EnvironmentObject var vm: HomeViewModel
    @Binding var flag: Bool
    @Binding var showingAlert: Bool
    @Binding var wantToCheckin: Bool
    @State private var swipeOffset: CGFloat = 0
    var id: UUID
    private var countdown: Countdown? {
        countdownStore.countdowns.filter({ $0.id == id }).first ?? nil
    }
    private var checkin: Checkin? {
        checkinStore.checkins.filter({ $0.id == id }).first ?? nil
    }

    var body: some View {
        ZStack {
            GeometryReader { geo in
                HStack(spacing: 0) {
                    // 打卡按钮
                    checkinButton
                    
                    // Content
                    HStack {
                        roundedRectangle
                        
                        content
                    }
                    .frame(width: geo.size.width)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .strokeStyle(cornerRadius: 8)
                    // pin heart
                    .overlay {
                        if flag {
                            if ((countdown?.isPinned) == true) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                    .position(x: 0, y: 0)
                            }
                        } else if ((checkin?.isPinned) == true) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .position(x: 0, y: 0)
                        }
                    }
                    .offset(x: swipeOffset)
                    .gesture(drag)
                    
                    // 删除按钮
                    deleteButton
                }
                .offset(x: -70)
            }
            .frame(height: 80)
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
        HStack {
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
                    Text(flag ? (countdown?.remainingDaysBool ?? true ? "还有 " : "已经 ") : "已经 ")
                        .font(.body)
                        .foregroundColor(.secondary)
                    Text(flag
                         ? String(abs(countdown?.remainingDays ?? 0))
                         : "\(checkin?.persistDay ?? 0)/\(checkin?.targetDate ?? "")")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(" 天")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "ellipsis.circle")
                .font(.title)
                .foregroundColor(.secondary)
                .padding(.trailing)
        }
    }
    
    var checkinButton: some View {
        Button {
            wantToCheckin = true
            vm.selectedData = checkin
            swipeOffset = 0
        } label: {
            Image(systemName: "flag.checkered.circle")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.cyan, in: Circle())
        }
        .offset(x: 60)
        .offset(x: swipeOffset - 60)
        .opacity(swipeOffset / 100)
        .padding(.trailing, 10)
    }
    
    var deleteButton: some View {
        Button {
            showingAlert = true
            if flag {
//                vm.selectedCountdown = countdown
            } else {
                vm.selectedData = checkin
            }
            swipeOffset = 0
        } label: {
            Image(systemName: "trash")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.red, in: Circle())
        }
        .offset(x: 60)
        .offset(x: swipeOffset - 60)
        .opacity(-swipeOffset / 100)
        .padding(.leading, 10)
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged({ value in
                if flag {
                    guard value.translation.width < 0 else { return }
                    swipeOffset = value.translation.width
                } else {
                    swipeOffset = value.translation.width
                }
            })
            .onEnded({ value in
                swipeOffset = flag
                ? (value.translation.width <= -70 ? -80 : 0)
                : (value.translation.width >= 70
                   ? 80
                   : (value.translation.width <= -70
                      ? -80
                      : 0
                     )
                )
            })
    }
}

struct ItemView_Previews: PreviewProvider {
    static let checkinStore = CheckinStore()
    static let countdownStore = CountdownStore()
    
    static var previews: some View {
        ItemView(flag: .constant(true), showingAlert: .constant(false), wantToCheckin: .constant(false), id: UUID())
            .environmentObject(checkinStore)
            .environmentObject(countdownStore)
    }
}
