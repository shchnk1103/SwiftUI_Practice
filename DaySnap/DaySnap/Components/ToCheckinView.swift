//
//  CheckinView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/15.
//

import SwiftUI
import WidgetKit

struct ToCheckinView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: HomeViewModel
    
    @Binding var flag: Bool
    @State private var appear: Bool = false
    // 上次点击按钮的日期
    @State private var checkinDate: Date?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.15)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                icon
                
                Spacer()
                
                content_1
                
                Spacer()
                
                content_2
                
                Spacer()
                
                button
                
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .foregroundColor(.white)
            .frame(height: 410)
            .frame(maxWidth: 350)
            .padding(.horizontal, 30)
            .offset(y: appear ? 0 : 1000)
        }
        .onTapGesture {
            withAnimation(.default.delay(0.3)) {
                appear = false
            }
            flag = false
        }
        .onAppear {
            withAnimation(.default.delay(0.3)) {
                appear = true
            }
        }
        .onDisappear {
            withAnimation(.default.delay(0.3)) {
                appear = false
            }
        }
    }
    
    var icon: some View {
        Text(vm.selectedCheckIn!.emojiText ?? "")
            .font(.system(size: 48))
            .frame(width: 120, height: 120)
            .background(.regularMaterial, in: Circle())
            .overlay {
                Circle()
                    .stroke(colorScheme == .dark ? .white : .black, lineWidth: 0.5)
            }
    }
    
    var content_1: some View {
        HStack(spacing: 0) {
            Text("已经坚持")
            Text(vm.selectedCheckIn!.name ?? "")
            Text(" \(vm.selectedCheckIn?.persistDay ?? 0) ")
                .font(.title)
                .fontWeight(.semibold)
            Text("天")
        }
        .foregroundColor(.primary)
    }
    
    var content_2: some View {
        HStack(spacing: 0) {
            Text("距离目标")
            Text(" \(vm.selectedCheckIn?.targetDate ?? "30") ")
                .font(.title)
                .fontWeight(.semibold)
            Text("天，还有")
            
            let targetDate = Int32(vm.selectedCheckIn!.targetDate ?? "30") ?? 30
            let persistDay = vm.selectedCheckIn!.persistDay
            let remainingDays = targetDate - persistDay
            
            Text("\(remainingDays)")
                .font(.title)
                .fontWeight(.semibold)
            Text("天")
        }
        .foregroundColor(.primary)
    }
    
    var button: some View {
        Button {
            if let checkin = vm.selectedCheckIn {
                if canCheckin(checkin: checkin) {
                    // 保存点击按钮的日期
                    checkin.lastCheckinTime = Date()
                    
                    checkin.persistDay += 1
                    checkin.isCheckin = true
                    
                    try? moc.save()
                    
                    WidgetCenter.shared.reloadAllTimelines()
                    
                    flag = false
                }
            } else {
                flag = false
            }
        } label: {
            HStack {
                Spacer()
                Text("打卡")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
        }
        .frame(height: 43)
        .frame(maxWidth: 300)
        .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

//struct CheckinView_Previews: PreviewProvider {
//    static let vm = HomeViewModel()
//
//    static var previews: some View {
//        ToCheckinView(flag: .constant(false))
//            .environmentObject(vm)
//    }
//}
