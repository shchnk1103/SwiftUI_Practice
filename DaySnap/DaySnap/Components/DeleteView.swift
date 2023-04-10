//
//  DeleteView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/26.
//

import SwiftUI

struct DeleteView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: HomeViewModel
    @AppStorage("flag") var flag: Bool = true
    
    @Binding var showingAlert: Bool
    @State private var appear: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.15)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Text(flag ? vm.selectedCountdown?.emojiText ?? "" : vm.selectedCheckIn?.emojiText ?? "")
                    .font(.system(size: 48))
                    .frame(width: 120, height: 120)
                    .background(.regularMaterial, in: Circle())
                    .overlay {
                        Circle()
                            .stroke(colorScheme == .dark ? .white : .black, lineWidth: 0.5)
                    }
                    .padding()
                
                Text(flag ? vm.selectedCountdown?.name ?? "" : vm.selectedCheckIn?.name ?? "")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                
                (Text("确定要删除吗？"))
                    .font(.title)
                    .padding()
                
                HStack {
                    Spacer()
                    
                    Button {
                        showingAlert = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .background(Color.gray, in: Circle())
                    }
                    
                    Spacer()
                    
                    deleteButton
                    
                    Spacer()
                }
                .padding()
            }
            .padding()
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke()
            )
            .frame(height: 410)
            .padding(.horizontal, 30)
            .offset(y: appear ? 0 : 1000)
        }
        .zIndex(9)
        .onTapGesture {
            showingAlert = false
        }
        .onAppear {
            withAnimation(.default.delay(0.3)) {
                appear = true
            }
        }
    }
    
    var deleteButton: some View {
        Button {
            let notificationManager = NotificationManager()
            
            if flag {
                do {
                    moc.delete(vm.selectedCountdown!)
                    
                    try? moc.save()
                    
                    notificationManager.deleteNotification(identifier: vm.selectedCountdown?.id?.uuidString ?? UUID().uuidString)
                }
            } else {
                do {
                    moc.delete(vm.selectedCheckIn!)
                    
                    try? moc.save()
                    
                    notificationManager.deleteNotification(identifier: vm.selectedCheckIn?.id?.uuidString ?? UUID().uuidString)
                }
            }
            
            showingAlert = false
        } label: {
            Image(systemName: "checkmark")
                .font(.title)
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color.red, in: Circle())
        }
    }
}

struct DeleteView_Previews: PreviewProvider {
    static let vm = HomeViewModel()

    static var previews: some View {
        DeleteView(showingAlert: .constant(true))
            .environmentObject(vm)
    }
}
