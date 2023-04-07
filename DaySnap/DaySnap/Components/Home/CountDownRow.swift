//
//  CountDownRow.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/7.
//

import SwiftUI

struct CountDownRow: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: HomeViewModel
    
    @State private var swipeOffset: CGFloat = 0
    @Binding var showingAlert: Bool
    
    var countdown: CountDown
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                HStack(spacing: 0) {
                    // 打卡按钮
                    checkinButton
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(
                                colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5),
                                lineWidth: 1
                            )
                            .frame(width: 60, height: 60)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .overlay {
                                Text(countdown.emojiText ?? "🥰")
                                    .font(.largeTitle)
                            }
                            .padding(10)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0) {
                                Text("距离 ")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                
                                Text(countdown.name ?? "")
                                    .font(.body)
                            }
                            
                            HStack(spacing: 0) {
                                Text(countdown.remainingDays > 0 ? "还有 " : "已经 ")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                
                                Text(String(abs(countdown.remainingDays)))
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
                    // pin heart
                    .overlay {
                        if countdown.isPinned {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .position(x: 0, y: 0)
                        }
                    }
                    .frame(width: geo.size.width)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .strokeStyle(cornerRadius: 8)
                    .offset(x: swipeOffset)
                    .gesture(drag)
                    
                    // 删除按钮
                    deleteButton
                }
                .offset(x: -70)
            }
            .frame(height: 80)
            .padding(.horizontal)
        }
    }
    
    var checkinButton: some View {
        Button {
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
            vm.selectedCountdown = countdown
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
                guard value.translation.width < 0 else { return }
                swipeOffset = value.translation.width
            })
            .onEnded({ value in
                swipeOffset = value.translation.width <= -70 ? -80 : 0
            })
    }
}

//struct CountDownRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CountDownRow(countdown: CountDown())
//    }
//}
