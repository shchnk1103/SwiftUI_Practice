//
//  AddView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/12.
//

import SwiftUI

struct AddView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var countdownStore: CountdownStore
    @EnvironmentObject var checkinStore: CheckinStore
    @AppStorage("flag") var flag: Bool = true
    @State private var isPinned: Bool = false
    @State private var isReminder: Bool = false
    @State private var text: String = ""
    @State private var emojiText: String = "🥳"
    @State private var deadline: Date = Date()
    @State private var reminderDate: Date = Date()
    @State private var persistDate: String = ""
    @State private var showAddSuccess: Bool = false
    @State private var showWarn: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 32) {
                Text("新建日程")
                    .font(.title2)
                    .padding(.top, 20)
                
                VStack(spacing: 32) {
                    SwitchView()
                    
                    VStack(spacing: 20) {
                        InputWithIconView(imageName: "applepencil", placeholderText: "写点有趣的", text: $text, emojiText: $emojiText)
                        
                        if flag {
                            CusDatePickerView(selectedDate: $deadline)
                        } else {
                            NumberOnlyTextField(persistDate: $persistDate)
                        }
                        
                        pinToggle
                        
                        VStack {
                            reminderToggle
                            
                            if isReminder {
                                CusDatePickerView(selectedDate: $reminderDate)
                            }
                        }
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .strokeStyle(cornerRadius: 8)
                        .shadow(color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), radius: 8, x: 0, y: 6)
                    }
                    
                    button
                }
                .padding(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
                }
                
                Spacer()
            }
            .padding(.horizontal, 15)
            .animation(.default, value: isReminder)
            
            if showAddSuccess {                
                SuccessView(flag: $showAddSuccess)
            }
            
            if showWarn {
                WarnView(flag: $showWarn)
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    var pinToggle: some View {
        Toggle(isOn: $isPinned, label: {
            HStack {
                Image(systemName: "square.topthird.inset.filled")
                    .foregroundColor(.secondary)
                    .padding(1)
                Text("置顶")
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25))
            }
        })
        .toggleStyle(CustomTopToggleStyle())
        .padding(10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .strokeStyle(cornerRadius: 8)
        .shadow(color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), radius: 8, x: 0, y: 6)
    }
    
    var reminderToggle: some View {
        Toggle(isOn: $isReminder, label: {
            HStack {
                Image(systemName: "timer")
                    .foregroundColor(.secondary)
                    .padding(1)
                Text("定期提醒")
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25))
            }
        })
        .toggleStyle(CustomTopToggleStyle())
        .padding(10)
    }
    
    var button: some View {
        Button {
            save()
        } label: {
            HStack {
                Spacer()
                Text("添加")
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding(.vertical, 12)
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
    
    func save() {
        if flag {
            if text.isEmpty {
                showWarn = true
            } else {
                 CountDownManager.shared.createCountDown(emojiText: emojiText, name: text, targetDate: deadline, isPinned: isPinned, isReminder: isReminder, notificationDate: reminderDate)
                
                // 请求通知授权
                let notificationManager = NotificationManager()
                notificationManager.requestAuthorization()
                
                // 发送通知
                notificationManager.sendNotification(title: "\(emojiText) \(text) 就是今天！", date: deadline)
                
                // 重置表单
                reset(flag: true)
                
                flag = false
                flag = true
            }
        } else {
            if text.isEmpty || persistDate.isEmpty {
                showWarn = true
            } else {
                let newCheckin = Checkin(emojiText: emojiText, name: text, targetDate: persistDate, isPinned: isPinned, isReminder: isReminder)
                checkinStore.add(checkin: newCheckin)
                
                // 请求通知授权
                let notificationManager = NotificationManager()
                notificationManager.requestAuthorization()
                
                // 发送通知
                notificationManager.scheduleRepeatingNotificationForCheckin(title: "\(emojiText) 今天 \(text) 了吗？快来打卡吧！", persisDays: persistDate)
                
                // 重置表单
                reset(flag: false)
                
                flag = true
                flag = false
            }
        }
    }
    
    func reset(flag: Bool) {
        if flag {
            self.emojiText = "🥳"
            self.text = ""
            self.deadline = Date()
            self.isPinned = false
            self.isReminder = false
            
            showAddSuccess = true
        } else {
            self.emojiText = "🥳"
            self.text = ""
            self.persistDate = ""
            self.isPinned = false
            self.isReminder = false
            
            showAddSuccess = true
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    static let checkinStore = CheckinStore()
    
    static var previews: some View {
        AddView()
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
    }
}
