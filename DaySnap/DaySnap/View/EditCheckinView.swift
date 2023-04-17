//
//  EditCheckinView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/16.
//

import SwiftUI

struct EditCheckinView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("flag") var flag: Bool = false
    
    @State private var text: String = ""
    @State private var emojiText: String = ""
    @State private var targetDate: String = ""
    @State private var isPinned: Bool = false
    @State private var isReminder: Bool = false
    @State private var reminderDate: Date = Date()
    @State private var selectedCategory: Int = 0
    
    var checkin: CheckIn
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 20) {
                InputWithIconView(imageName: "applepencil", placeholderText: "写点有趣的", text: $text, emojiText: $emojiText)
                    .onAppear {
                        self.text = checkin.name ?? ""
                        self.emojiText = checkin.emojiText ?? ""
                    }
                
                NumberOnlyTextField(persistDate: $targetDate)
                    .onAppear {
                        self.targetDate = String(checkin.targetDate ?? "7")
                    }
                
                pinToggle
                
                VStack {
                    reminderToggle
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
        .navigationTitle(checkin.name ?? "Unkown")
        .navigationBarTitleDisplayMode(.inline)
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
            self.isPinned = checkin.isPinned
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
            self.isReminder = checkin.isReminder
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
        checkin.name = text
        checkin.emojiText = emojiText
        checkin.targetDate = targetDate
        checkin.isPinned = isPinned
        checkin.isReminder = isReminder
        checkin.notificationDate = reminderDate
        
        try? moc.save()
    }
}

//struct EditCheckinView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCheckinView(checkin: CheckIn())
//    }
//}
