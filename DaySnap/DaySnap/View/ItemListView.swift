//
//  ItemListView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct ItemListView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var countdownStore: CountdownStore
    @EnvironmentObject var checkinStore: CheckinStore
    @EnvironmentObject var vm: HomeViewModel
    @Binding var flag: Bool
    @Binding var wantToCheckin: Bool
    @State private var showingAlert = false
    @State private var countdownToDelete: Countdown? = nil
    @State private var selectedCountdown: Countdown? = nil
    @State private var checkinToDelete: Checkin? = nil
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack {
            if flag {
                if countdownStore.countdowns.isEmpty {
                    Text("nothing")
                    Spacer()
                } else {
                    List {
                        ForEach(countdownStore.countdowns) { countdown in
                            ItemView(flag: $flag, id: countdown.id)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        showingAlert = true
                                        countdownToDelete = countdown
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                }
                                .onTapGesture {
                                    self.selectedCountdown = countdown
                                }
                        }
                        .sheet(item: $selectedCountdown) { countdown in
                            EditView(item: $countdownStore.countdowns[countdownStore.countdowns.firstIndex(of: countdown)!])
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    
                    Spacer()
                }
            } else {
                if checkinStore.checkins.isEmpty {
                    Text("nothing")
                    Spacer()
                } else {
                    List(checkinStore.checkins) { checkin in
                        ItemView(flag: $flag, id: checkin.id)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            // 删除按钮
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    showingAlert = true
                                    checkinToDelete = checkin
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                            // 打卡按钮
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button {
                                    wantToCheckin = true
                                    vm.selectedData = checkin
                                } label: {
                                    Image(systemName: "flag.checkered.circle")
                                }
                                .tint(.cyan)
                            }
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .padding()
        // 确认删除
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("删除确认"),
                message: Text(flag ? "您确定要删除这个倒数日吗？" : "您确定要删除这个打卡项吗？"),
                primaryButton: .destructive(Text("确定")) {
                    if let item = countdownToDelete {
                        countdownStore.delete(countdown: item)
                        countdownToDelete = nil
                        flag = false
                        flag = true
                    }
                    if let item = checkinToDelete {
                        checkinStore.delete(checkin: item)
                        checkinToDelete = nil
                        flag = true
                        flag = false
                    }
                },
                secondaryButton: .cancel(Text("取消")))
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    static let checkinStore = CheckinStore()
    static let vm = HomeViewModel()
    
    static var previews: some View {
        ItemListView(flag: .constant(true), wantToCheckin: .constant(false))
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
            .environmentObject(vm)
    }
}
