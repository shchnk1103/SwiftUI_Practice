//
//  DeleteView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/26.
//

import SwiftUI

struct DeleteView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var countdownStore: CountdownStore
    @EnvironmentObject var checkinStore: CheckinStore
    @EnvironmentObject var vm: HomeViewModel
    @AppStorage("flag") var flag: Bool = true
    @Binding var showingAlert: Bool
    @State private var appear: Bool = false
    
    var body: some View {
        ZStack {
            Color.gray
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(0.25)
            
            VStack(alignment: .center) {
                Text(flag ? vm.selectedCountdown?.emojiText ?? "" : vm.selectedData?.emojiText ?? "")
                    .font(.system(size: 48))
                    .frame(width: 120, height: 120)
                    .background(.regularMaterial, in: Circle())
                    .overlay {
                        Circle()
                            .stroke(colorScheme == .dark ? .white : .black, lineWidth: 0.5)
                    }
                    .padding()
                
                Text(flag ? vm.selectedCountdown?.name ?? "" : vm.selectedData?.name ?? "")
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
                    
                    Button {
                        showingAlert = false
                        
                        if flag {
                            if let countdown = vm.selectedCountdown {
                                countdownStore.delete(countdown: countdown)
                            }
                            
                            flag = false
                            flag = true
                        } else {
                            if let checkin = vm.selectedData {
                                checkinStore.delete(checkin: checkin)
                            }
                            
                            flag = true
                            flag = false
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.title)
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .background(Color.red, in: Circle())
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
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
}

struct DeleteView_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    static let checkinStore = CheckinStore()
    static let vm = HomeViewModel()
    
    static var previews: some View {
        DeleteView(showingAlert: .constant(true))
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
            .environmentObject(vm)
    }
}
