//
//  AddView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/12.
//

import SwiftUI
import WidgetKit

struct AddView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var userViewModel: UserViewModel
    @FetchRequest(sortDescriptors: []) var countdowns: FetchedResults<CountDown>
    @FetchRequest(sortDescriptors: []) var checkins: FetchedResults<CheckIn>
    
    @AppStorage("flag") var flag: Bool = true
    // 自定义颜色
    @AppStorage("colorCustom") var colorCustom: String = ""
    // 自定义按钮颜色
    @AppStorage("colorButton") var colorButton: String = ""
    // 数据
    @State private var isPinned: Bool = false
    @State private var isReminder: Bool = false
    @State private var text: String = ""
    @State private var emojiText: String = "🥳"
    @State private var deadline: Date = Date()
    @State private var persistDate: String = ""
    @State private var selectedCategory: Int = 0
    @State private var selectedReminder: Int = 0
    // 弹窗
    @State private var showAddSuccess: Bool = false
    @State private var showWarn: Bool = false
    @State private var warnStatus: Int = 0
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                addContent
            }
        } else {
            NavigationView {
                addContent
            }
        }
    }
    
    var addContent: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 32) {
                    SwitchView()
                    
                    VStack(spacing: 20) {
                        InputWithIconView(imageName: "applepencil", placeholderText: "写点有趣的", text: $text, emojiText: $emojiText)
                        
                        if flag {
                            CusDatePickerView(selectedDate: $deadline)
                            
                            category
                        } else {
                            NumberOnlyTextField(persistDate: $persistDate)
                        }
                        
                        pinToggle
                        
                        VStack {
                            reminderToggle
                            
                            if isReminder {
                                HStack {
                                    if flag {
                                        Text("如果超过目标日期将不通知")
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    } else {
                                        Text("如果超过坚持天数将不通知")
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Picker("", selection: $selectedReminder) {
                                        ForEach(reminders) { reminder in
                                            Text(reminder.name)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                                }
                                .padding([.bottom, .horizontal])
                            }
                        }
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .strokeStyle(cornerRadius: 8)
                        .shadow(
                            color: colorScheme == .dark
                            ? .white.opacity(0.25)
                            : .black.opacity(0.25),
                            radius: 4, x: 0, y: 2)
                    }
                    
                    button
                }
                .padding(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
                }
                .padding(.horizontal, 15)
                .animation(.default, value: isReminder)
                
                Spacer()
            }
            
            if showAddSuccess {
                SuccessView(flag: $showAddSuccess)
            }
            
            if showWarn {
                WarnView(flag: $showWarn, status: $warnStatus)
            }
        }
        .navigationTitle("新建日程")
        .onTapGesture {
            // 强制隐藏键盘
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    var category: some View {
        HStack {
            Image(systemName: "list.bullet")
                .foregroundColor(.secondary)
            
            Text("请选择分类")
                .foregroundColor(colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25))
            
            Spacer()
            
            Picker(selection: $selectedCategory, label: Text("选择分类")) {
                ForEach(categories, id: \.id) { category in
                    HStack {
                        Image(systemName: category.icon)
                        Text(category.name)
                    }
                    .tag(category)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray.opacity(0.15))
            )
        }
        .padding(10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .strokeStyle(cornerRadius: 8)
        .shadow(color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), radius: 4, x: 0, y: 2)
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
        .shadow(color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), radius: 4, x: 0, y: 2)
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
                    .foregroundColor(
                        colorScheme == .dark
                        ? (colorCustom == ""
                           ? .black.opacity(0.8)
                           : .white.opacity(0.8))
                        : (colorCustom == ""
                           ? .white
                           : .white.opacity(0.8))
                    )
                    .padding(.vertical, 12)
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .buttonBackgroundColor()
        }
    }
    
    // MARK: functions
    func save() {
        let isSubscription = userViewModel.isSubscriptionActive
        
        if flag {
            guard !text.isEmpty else {
                // 0 -> text为空
                warnStatus = 0
                showWarn = true
                return
            }
            
            if countdowns.count < 5 {
                addCountDown()
                // 重置表单
                reset(flag: true)
            } else if isSubscription {
                addCountDown()
                // 重置表单
                reset(flag: true)
            } else {
                // 用户没有开通会员
                warnStatus = 1
                showWarn = true
            }
        } else {
            guard !text.isEmpty || !persistDate.isEmpty else {
                warnStatus = 0
                showWarn = true
                return
            }
            
            if checkins.count < 5 {
                addCheckIn()
                // 重置表单
                reset(flag: false)
            } else if isSubscription {
                addCheckIn()
                // 重置表单
                reset(flag: false)
            } else {
                warnStatus = 1
                showWarn = true
            }
        }
    }
    
    // MARK: functions
    func addCountDown() {
        let date = calNextNotificationTime(selectedReminder: selectedReminder)
        
        let countdown = CountDown(context: moc)
        countdown.id = UUID()
        countdown.emojiText = emojiText
        countdown.name = text
        countdown.targetDate = deadline
        countdown.isPinned = isPinned
        countdown.isReminder = isReminder
        countdown.notificationDate = date
        countdown.remainingDays = calRemainingDays(targetDay: deadline)
        countdown.category = categories[selectedCategory].name
        countdown.reminderEvent = Int16(selectedReminder)
        
        try? moc.save()
        
        WidgetCenter.shared.reloadAllTimelines()
        
        if isReminder {
            // 请求通知授权
            let notificationManager = NotificationManager()
            notificationManager.requestAuthorization()
            
            // 发送通知
            notificationManager.sendNotification(countdown: countdown, identifier: countdown.id?.uuidString ?? UUID().uuidString)
        }
    }
    
    func addCheckIn() {
        let checkin = CheckIn(context: moc)
        checkin.id = UUID()
        checkin.emojiText = emojiText
        checkin.name = text
        checkin.targetDate = persistDate
        checkin.isPinned = isPinned
        checkin.isReminder = isReminder
        checkin.notificationDate = Date()
        checkin.persistDay = 0
        checkin.reminderEvent = Int16(selectedReminder)
        
        try? moc.save()
        
        WidgetCenter.shared.reloadAllTimelines()
        
        if isReminder {
            // 请求通知授权
            let notificationManager = NotificationManager()
            notificationManager.requestAuthorization()
            
            // 发送通知
            notificationManager.scheduleRepeatingNotificationForCheckin(title: "\(emojiText) 今天 \(text) 了吗？快来打卡吧！", persisDays: persistDate, identifier: checkin.id?.uuidString ?? UUID().uuidString, reminderEvent: selectedReminder)
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
    static var previews: some View {
        AddView()
    }
}
