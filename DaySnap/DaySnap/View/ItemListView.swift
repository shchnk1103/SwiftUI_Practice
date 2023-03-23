//
//  ItemListView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var countdownStore: CountdownStore
    @EnvironmentObject var checkinStore: CheckinStore
    @EnvironmentObject var vm: HomeViewModel
    @Binding var flag: Bool
    @Binding var wantToCheckin: Bool
    @State private var showingAlert = false
    @State private var countdownToDelete: Countdown? = nil
    @State private var checkinToDelete: Checkin? = nil
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if flag {
                        if countdownStore.countdowns.isEmpty {
                            Text("nothing")
                        } else {
                            ForEach(countdownStore.countdowns, id: \.self) { item in
                                NavigationLink(value: item, label: {
                                    ItemView(flag: $flag, id: item.id)
                                })
                                .navigationDestination(for: Countdown.self, destination: { item in
                                    EditView(item: $countdownStore.countdowns[countdownStore.countdowns.firstIndex(of: item)!])
                                })
                                // 删除按钮
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        showingAlert = true
                                        countdownToDelete = item
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                    } else {
                        if checkinStore.checkins.isEmpty {
                            Text("nothing")
                        } else {
                            ForEach(checkinStore.checkins, id: \.self) { item in
                                NavigationLink(destination: EmptyView()) {
                                    ItemView(flag: $flag, id: item.id)
                                }
                                // 删除按钮
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        showingAlert = true
                                        checkinToDelete = item
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                }
                                // 打卡按钮
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button {
                                        wantToCheckin = true
                                        vm.selectedData = item
                                    } label: {
                                        Image(systemName: "flag.checkered.circle")
                                    }
                                    .tint(.cyan)
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
                .id(UUID())
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
    }
}

struct ItemListView_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    static let checkinStore = CheckinStore()
    static let vm = HomeViewModel()
    
    static var previews: some View {
        ItemListView(flag: .constant(false), wantToCheckin: .constant(false))
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
            .environmentObject(vm)
    }
}
