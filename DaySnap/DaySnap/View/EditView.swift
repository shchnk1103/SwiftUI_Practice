//
//  EditView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/20.
//

import SwiftUI

struct EditView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var countdownStore: CountdownStore
    @AppStorage("flag") var flag: Bool = true
    @State private var text: String = ""
    @State private var emojiText: String = ""
    @State private var targetDate: Date = Date()
    @State private var isPinned: Bool = false
    @State private var isReminder: Bool = false
    @State private var reminderDate: Date = Date()
    @Binding var selectedItem: Countdown?
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var body: some View {

            VStack(spacing: 32) {
                VStack(spacing: 20) {
                    InputWithIconView(imageName: "applepencil", placeholderText: "写点有趣的", text: $text, emojiText: $emojiText)
                        .onAppear {
                            self.text = selectedItem!.name
                            self.emojiText = selectedItem!.emojiText
                        }
                    
                    CusDatePickerView(selectedDate: $targetDate)
                        .onAppear {
                            self.targetDate = selectedItem!.targetDate
                        }
                    
                    pinToggle
                    
                    VStack {
                        reminderToggle
                        
                        if isReminder {
                            CusDatePickerView(selectedDate: $reminderDate)
                                .onAppear {
                                    self.reminderDate = selectedItem!.notificationDate
                                }
                        }
                    }
                    .background(colorScheme == .dark ? .gray.opacity(0.5) : .white)
                    .cornerRadius(8)
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
            self.isPinned = selectedItem!.isPinned
        }
        .padding(10)
        .background(colorScheme == .dark ? .gray.opacity(0.5) : .white)
        .cornerRadius(8)
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
            self.isReminder = selectedItem!.isReminder
        }
        .padding(10)
    }
    
    var button: some View {
        Button {
            update()
            
            // 关闭sheet
            selectedItem = nil
        } label: {
            HStack {
                Spacer()
                Text("更新")
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding(.vertical, 12)
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
    
    // MARK: fuctions
    
    func update() {
        guard let selectedCountdown = selectedItem else { return }
        
        let updatedCountdown = Countdown(id: selectedCountdown.id, emojiText: emojiText, name: text, targetDate: targetDate, isPinned: isPinned, isReminder: isReminder, notificationDate: reminderDate)
        
        countdownStore.update(countdown: updatedCountdown)
        
        flag = false
        flag = true
    }
}

struct EditView_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    
    static var previews: some View {
        EditView(selectedItem: .constant(Countdown(emojiText: "", name: "test", targetDate: Date(), isPinned: false, isReminder: false, notificationDate: Date())))
            .environmentObject(countdownStore)
    }
}
