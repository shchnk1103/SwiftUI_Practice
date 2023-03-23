//
//  TestView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/14.
//

import SwiftUI

struct TestView: View {
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
        List(checkinStore.checkins) { checkin in
            ItemView(flag: .constant(false), id: checkin.id)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                    }

                }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static let checkinStore = CheckinStore()
    static let countdownStore = CountdownStore()
    
    static var previews: some View {
        TestView(flag: .constant(false), wantToCheckin: .constant(false))
            .environmentObject(checkinStore)
            .environmentObject(countdownStore)
    }
}
