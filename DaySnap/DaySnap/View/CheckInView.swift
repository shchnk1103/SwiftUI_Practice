//
//  CheckInView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/7.
//

import SwiftUI

struct CheckInView: View {
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(sortDescriptors: []) var checkins: FetchedResults<CheckIn>
    @EnvironmentObject var vm: HomeViewModel
    
    @Binding var showingAlert: Bool
    @Binding var wantToCheckin: Bool
    @State private var showSheet: Bool = false
    
    var body: some View {
        if checkins.isEmpty {
            VStack {
                Spacer()
                
                Image("nv")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
            }
        } else {
            ForEach(checkins) { checkin in
                CheckInRow(showingAlert: $showingAlert, wantToCheckin: $wantToCheckin, checkin: checkin)
                    .padding(.horizontal)
//                CountDownRow(showingAlert: $showingAlert, countdown: checkin)
//                    .onTapGesture {
//                        showSheet = true
//                        vm.selectedCheckIn = checkin
//                    }
            }
//            .sheet(isPresented: $showSheet) {
//                EditView(countdown: vm.selectedCheckIn!)
//            }
        }
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView(showingAlert: .constant(false), wantToCheckin: .constant(false))
    }
}
