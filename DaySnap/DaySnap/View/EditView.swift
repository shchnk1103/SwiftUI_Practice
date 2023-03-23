//
//  EditView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/20.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var countdownStore: CountdownStore
    @Binding var item: Countdown
    @State private var text: String = ""
    @State private var emojiText: String = ""
    @State private var targetDate: Date = Date()
    @State private var isPinned: Bool = false
    @State private var isReminder: Bool = false
    @State private var reminderDate: Date = Date()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(spacing: 32) {
                VStack(spacing: 20) {
                    InputWithIconView(imageName: "applepencil", placeholderText: "写点有趣的", text: $text, emojiText: $emojiText)
                        .onAppear {
                            self.text = self.item.name
                            self.emojiText = self.item.emojiText
                        }
                        .onDisappear {
                            self.item.name = self.text
                            self.item.emojiText = self.emojiText
                        }
                    
                    CusDatePickerView(selectedDate: $targetDate)
                        .onAppear {
                            self.targetDate = self.item.targetDate
                        }
                        .onDisappear {
                            self.item.targetDate = self.targetDate
                        }
                    
                    pinToggle
                    
                    VStack {
                        reminderToggle
                        
                        if isReminder {
                            CusDatePickerView(selectedDate: $reminderDate)
                                .onAppear {
                                    self.reminderDate = self.item.notificationDate
                                }
                                .onDisappear {
                                    self.item.notificationDate = self.reminderDate
                                }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 0)
                }
                
                button
            }
            .padding(20)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.black, lineWidth: 1)
            }
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.top, 50)
    }
    
    var pinToggle: some View {
        Toggle(isOn: $isPinned) {
            HStack {
                Image(systemName: "square.topthird.inset.filled")
                    .padding(1)
                Text("置顶")
                    .foregroundColor(.black.opacity(0.25))
            }
        }
        .toggleStyle(CustomTopToggleStyle())
        .onAppear {
            self.isPinned = self.item.isPinned
        }
        .onDisappear {
            self.item.isPinned = self.isPinned
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 0)
    }
    
    var reminderToggle: some View {
        Toggle(isOn: $isReminder, label: {
            HStack {
                Image(systemName: "timer")
                    .padding(1)
                Text("定期提醒")
                    .foregroundColor(.black.opacity(0.25))
            }
        })
        .toggleStyle(CustomTopToggleStyle())
        .onAppear {
            self.isReminder = self.item.isReminder
        }
        .onDisappear {
            self.item.isReminder = self.isReminder
        }
        .padding(10)
    }
    
    var button: some View {
        Button {
            update()
        } label: {
            HStack {
                Spacer()
                Text("更新")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .foregroundColor(.black)
        }
    }
    
    func update() {
        let countdown = Countdown(emojiText: emojiText, name: text, targetDate: targetDate, isPinned: isPinned, isReminder: isReminder, notificationDate: reminderDate)
        
        if let index = countdownStore.countdowns.firstIndex(where: { $0.id == item.id }) {
            countdownStore.countdowns[index] = countdown
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    
    static var previews: some View {
        EditView(item: .constant(Countdown(emojiText: "🥰", name: "健身", targetDate: Date(), isPinned: false, isReminder: false, notificationDate: Date())))
            .environmentObject(countdownStore)
    }
}
