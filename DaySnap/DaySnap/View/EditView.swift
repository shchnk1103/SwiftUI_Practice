//
//  EditView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/20.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("flag") var flag: Bool = true
    
    @State private var text: String = ""
    @State private var emojiText: String = ""
    @State private var targetDate: Date = Date()
    @State private var isPinned: Bool = false
    @State private var isReminder: Bool = false
    @State private var reminderDate: Date = Date()
    @State private var selecredCategory: Category = categories[0]
    
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
                        CusDatePickerView(selectedDate: $reminderDate)
                            .onAppear {
                                self.reminderDate = countdown.notificationDate ?? Date()
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
            
            Picker(selection: $selecredCategory, label: Text("选择分类")) {
                ForEach(categories, id: \.self) { category in
                    HStack {
                        Image(systemName: category.icon)
                        Text(category.name)
                    }
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
                self.selecredCategory = categories[index]
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
        countdown.name = text
        countdown.emojiText = emojiText
        countdown.targetDate = targetDate
        countdown.isPinned = isPinned
        countdown.isReminder = isReminder
        countdown.notificationDate = reminderDate
        countdown.remainingDays = calRemainingDays(targetDay: targetDate)
        countdown.category = selecredCategory.name
        
        try? moc.save()
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(countdown: CountDown())
//    }
//}
