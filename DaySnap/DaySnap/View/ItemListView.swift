//
//  ItemListView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct ItemListView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var checkinStore: CheckinStore
    @AppStorage("flag") var flag: Bool = true
    @Binding var wantToCheckin: Bool
    @Binding var showingAlert: Bool
    @State private var checkinToDelete: Checkin? = nil
    @State private var showSheet: Bool = false
    @State private var selectedCountdown: CountDown = CountDown()
    @ObservedObject var countdownManager = CountDownManager.shared
    
    var body: some View {
        VStack {
            if flag {
                if countdownManager.countdowns.isEmpty {
                    Spacer()
                    
                    Image("nan")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                } else {
                    ForEach(countdownManager.countdowns) { countdown in
                        CountdownItemRow(
                            wantToCheckin: $wantToCheckin,
                            showingAlert: $showingAlert,
                            countdown: countdown
                        )
                        .padding(.horizontal)
                        .onTapGesture {
                            selectedCountdown = countdown
                            showSheet = true
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        EditView(countdown: $selectedCountdown)
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
