//
//  CheckInRow.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/7.
//

import SwiftUI

struct CheckInRow: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: HomeViewModel
    
    @Binding var showingAlert: Bool
    @Binding var wantToCheckin: Bool
    @State private var swipeOffset: CGFloat = 0
    
    var checkin: CheckIn
    
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
                        if checkin.isPinned {
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
                Text(checkin.emojiText ?? "🥰")
                    .font(.largeTitle)
            }
            .padding(10)
    }
    
    var content: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text("坚持 ")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Text(checkin.name ?? "")
                        .font(.body)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                
                HStack(alignment: .center, spacing: 0) {
                    Text("已经 ")
                        .font(.body)
                        .foregroundColor(.secondary)
                    Text("\(checkin.persistDay)/\(checkin.targetDate ?? "")")
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
            vm.selectedCheckIn = checkin
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
            vm.selectedCheckIn = checkin
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
                swipeOffset = value.translation.width
            })
            .onEnded({ value in
                swipeOffset = value.translation.width >= 70
                   ? 80
                   : (value.translation.width <= -70
                      ? -80
                      : 0)
            })
    }
}

//struct CheckInRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckInRow(showingAlert: .constant(false), wantToCheckin: .constant(false), checkin: <#CheckIn#>)
//    }
//}
