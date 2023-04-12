//
//  CheckinView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/15.
//

import SwiftUI

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
                if canCheckin() {
                    // 保存点击按钮的日期
                    checkinDate = Date()
                    setLastCheckinTime(checkinDate!)
                    
                    checkin.persistDay += 1
                    
                    try? moc.save()
                    
                    flag = false
                }
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
        .disabled(!canCheckin())
        .frame(height: 43)
        .frame(maxWidth: 300)
        .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
    
    // MARK: functions
    // 设置上次 Click In 按钮点击的确切时间
    private func setLastCheckinTime(_ time: Date) {
        let timeInterval = time.timeIntervalSinceReferenceDate
        UserDefaults.standard.setValue(timeInterval, forKey: "lastCheckinTime")
    }
    
    // 获取上次 Click In 按钮点击的确切时间
    private func getLastCheckinTime() -> Date? {
        guard let timeInterval = UserDefaults.standard.value(forKey: "lastCheckinTime") as? TimeInterval else {
            return nil
        }
        return Date(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    // 检查是否可以点击 Check In 按钮
    private func canCheckin() -> Bool {
        guard let lastCheckinTime = getLastCheckinTime() else { return true }
        
        let calendar = Calendar.current
        let today = Date()
        
        let lastCheckinDay = calendar.component(.day, from: lastCheckinTime)
        let todayDay = calendar.component(.day, from: today)
        
        return todayDay != lastCheckinDay
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
