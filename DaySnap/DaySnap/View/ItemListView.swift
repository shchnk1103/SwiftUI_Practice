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
    @EnvironmentObject var vm: HomeViewModel
    @AppStorage("flag") var flag: Bool = true
    @Binding var wantToCheckin: Bool
    @Binding var showingAlert: Bool
    @State private var selectedCountdown: CountDown = CountDown()
    @State private var checkinToDelete: Checkin? = nil
    @State private var swipeOffset: CGFloat = 0
    @State private var showSheet: Bool = false
    @State private var countdowns: [CountDown] = []
    
    var body: some View {
        VStack {
            if flag {
                if countdowns.isEmpty {
                    Spacer()
                    
                    Image("nan")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                } else {
                    ForEach(countdowns) { countdown in
                        CountdownItemRow(
                            wantToCheckin: $wantToCheckin,
                            showingAlert: $showingAlert,
                            countdown: countdown
                        )
                        .padding(.horizontal)
                        .onTapGesture {
                            vm.selectedCountdown = countdown
                            showSheet = true
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        EditView(showSheet: $showSheet)
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
        .onAppear {
            countdowns = CountDownManager.shared.fetchAllCountDowns()
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
