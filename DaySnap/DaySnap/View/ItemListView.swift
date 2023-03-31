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
    @Binding var showingAlert: Bool
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
                    ForEach(countdownStore.countdowns) { countdown in
                        ItemView(flag: $flag, showingAlert: $showingAlert, wantToCheckin: $wantToCheckin, id: countdown.id)
                            .onTapGesture {
                                self.selectedCountdown = countdown
                            }
                            .padding(.horizontal)
                    }
                    .sheet(item: $selectedCountdown) { countdown in
                        EditView(item: $countdownStore.countdowns[countdownStore.countdowns.firstIndex(of: countdown)!])
                    }
                    
                    Spacer()
                }
            } else {
                if checkinStore.checkins.isEmpty {
                    Text("nothing")
                    Spacer()
                } else {
                    ForEach(checkinStore.checkins) { checkin in
                        ItemView(flag: $flag, showingAlert: $showingAlert, wantToCheckin: $wantToCheckin, id: checkin.id)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
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
        ItemListView(flag: .constant(false), wantToCheckin: .constant(false), showingAlert: .constant(false))
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
            .environmentObject(vm)
    }
}
