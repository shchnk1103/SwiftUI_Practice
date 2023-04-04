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
    @AppStorage("flag") var flag: Bool = true
    @Binding var wantToCheckin: Bool
    @Binding var showingAlert: Bool
    @State private var selectedCountdown: Countdown? = nil
    @State private var checkinToDelete: Checkin? = nil
    
    var body: some View {
        VStack {
            if flag {
                if countdownStore.countdowns.isEmpty {
                    Spacer()
                    
                    Image("nan")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                } else {
                    ForEach(countdownStore.countdowns.sortedByPriority()) { countdown in
                        ItemView(flag: $flag, showingAlert: $showingAlert, wantToCheckin: $wantToCheckin, id: countdown.id)
                            .onTapGesture {
                                self.selectedCountdown = countdown
                            }
                            .padding(.horizontal)
                    }
                    .sheet(item: $selectedCountdown) { countdown in
                        EditView(selectedItem: $selectedCountdown)
                    }
                    
                    Spacer()
                }
            } else {
                if checkinStore.checkins.isEmpty {
                    Spacer()
                    
                    Image("nv")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
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
        ItemListView(wantToCheckin: .constant(false), showingAlert: .constant(false))
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
            .environmentObject(vm)
    }
}
