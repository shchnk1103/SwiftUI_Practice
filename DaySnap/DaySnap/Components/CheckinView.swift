//
//  CheckinView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/15.
//

import SwiftUI

struct CheckinView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var checkinStore: CheckinStore
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
        Circle()
            .stroke(lineWidth: 1)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(width: 120, height: 120)
            .overlay {
                Text(vm.selectedData?.emojiText ?? "💪🏼")
                    .font(.system(size: 48))
            }
    }
    
    var content_1: some View {
        HStack(spacing: 0) {
            Text("已经坚持")
            Text("\(vm.selectedData?.name ?? "")")
            Text(" \(vm.selectedData?.persistDay ?? 0) ")
                .font(.title)
                .fontWeight(.semibold)
            Text("天")
        }
    }
    
    var content_2: some View {
        HStack(spacing: 0) {
            Text("距离目标")
            Text(" \(vm.selectedData?.targetDate ?? "30") ")
                .font(.title)
                .fontWeight(.semibold)
            Text("天，还有")
            Text(" \((Int(vm.selectedData?.targetDate ?? "30") ?? 30) - (vm.selectedData?.persistDay ?? 0)) ")
                .font(.title)
                .fontWeight(.semibold)
            Text("天")
        }
    }
    
    var button: some View {
        Button {
            if var checkin = vm.selectedData {
                if canCheckin() {
                    // 保存点击按钮的日期
                    checkinDate = Date()
                    setLastCheckinTime(checkinDate!)
                    
                    checkin.persistDay += 1
                    checkinStore.update(checkin: checkin)
                    
                    // 重新渲染页面
                    self.vm.selectedData?.persistDay = checkin.persistDay
                }
                
                flag = true
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
        .disabled(!canCheckin())
        .frame(height: 43)
        .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
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

struct CheckinView_Previews: PreviewProvider {
    static let vm = HomeViewModel()
    static let checkinStore = CheckinStore()
    
    static var previews: some View {
        CheckinView(flag: .constant(true))
            .environmentObject(vm)
            .environmentObject(checkinStore)
    }
}
