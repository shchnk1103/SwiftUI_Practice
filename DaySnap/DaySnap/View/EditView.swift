//
//  EditView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/20.
//

import SwiftUI
import WidgetKit

struct EditView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("flag") var flag: Bool = true
    // 自定义颜色
    @AppStorage("colorCustom") var colorCustom: String = ""
    
    @State private var text: String = ""
    @State private var emojiText: String = ""
    @State private var targetDate: Date = Date()
    @State private var isPinned: Bool = false
    @State private var isReminder: Bool = false
    @State private var reminderDate: Date = Date()
    @State private var selectedCategory: Int = 0
    @State private var selectedReminder: Int = 0
    
    var countdown: CountDown
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 20) {
                InputWithIconView(imageName: "applepencil", placeholderText: "写点有趣的", text: $text, emojiText: $emojiText)
                    .onAppear {
                        self.text = countdown.name ?? ""
                        self.emojiText = countdown.emojiText ?? ""
                    }
                
                CusDatePickerView(selectedDate: $targetDate)
                    .onAppear {
                        self.targetDate = countdown.targetDate ?? Date()
                    }
                
                category
                
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
                .shadow(color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), radius: 8, x: 0, y: 0)
                .animation(.default, value: isReminder)
            }
            
            button
        }
        .padding(20)
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 1)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 15)
        .padding(.top, 50)
        .animation(.default, value: isReminder)
        .navigationTitle(countdown.name ?? "Unkown")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var category: some View {
        HStack {
            Image(systemName: "list.bullet")
                .foregroundColor(.secondary)
            
            Text("请选择分类")
                .foregroundColor(colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25))
            
            Spacer()
            
            Picker(selection: $selectedCategory, label: Text("选择分类")) {
                ForEach(categories, id: \.self) { category in
                    HStack {
                        Image(systemName: category.icon)
                        Text(category.name)
                    }
                    .tag(category.id)
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
        .shadow(color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), radius: 8, x: 0, y: 6)
        .onAppear {
            if let index = categories.firstIndex(where: { $0.name == countdown.category }) {
                self.selectedCategory = index
            }
        }
    }
    
    var pinToggle: some View {
        Toggle(isOn: $isPinned) {
            HStack {
                Image(systemName: "square.topthird.inset.filled")
                    .foregroundColor(.secondary)
                    .padding(1)
                Text("置顶")
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25))
            }
        }
        .toggleStyle(CustomTopToggleStyle())
        .onAppear {
            self.isPinned = countdown.isPinned
        }
        .padding(10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .strokeStyle(cornerRadius: 8)
        .shadow(color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), radius: 8, x: 0, y: 0)
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
        .onAppear {
            self.isReminder = countdown.isReminder
        }
        .padding(10)
    }
    
    var button: some View {
        Button {
            update()
            
            // 关闭sheet
            dismiss()
        } label: {
            HStack {
                Spacer()
                Text("更新")
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
    
    // MARK: fuctions
    
    func update() {
        let date = calNextNotificationTime(selectedReminder: selectedReminder)

        countdown.emojiText = emojiText
        countdown.name = text
        countdown.targetDate = targetDate
        countdown.isPinned = isPinned
        countdown.isReminder = isReminder
        countdown.notificationDate = date
        countdown.remainingDays = calRemainingDays(targetDay: targetDate)
        countdown.category = categories[selectedCategory].name
        countdown.reminderEvent = Int16(selectedReminder)
        
        try? moc.save()
        
        WidgetCenter.shared.reloadAllTimelines()
        
        let notificationManager = NotificationManager()
        if isReminder {
            // 请求通知授权
            notificationManager.requestAuthorization()
            
            // 发送通知
            notificationManager.sendNotification(countdown: countdown, identifier: countdown.id?.uuidString ?? UUID().uuidString)
        } else {
            // 删除通知
            notificationManager.deleteNotification(identifier: countdown.id?.uuidString ?? UUID().uuidString)
        }
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(countdown: CountDown())
//    }
//}
