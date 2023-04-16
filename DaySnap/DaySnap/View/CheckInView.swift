//
//  CheckInView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/7.
//

import SwiftUI

struct CheckInView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var vm: HomeViewModel
    @FetchRequest(sortDescriptors: []) var checkins: FetchedResults<CheckIn>
    
    @Binding var showingAlert: Bool
    @Binding var wantToCheckin: Bool
    @State private var showSheet: Bool = false
    
    var body: some View {
        let checkinsCount = checkins.filter({ $0.isCheckin }).count
        let progress = Double(checkinsCount) / Double(checkins.count)
        
        if checkins.isEmpty {
            VStack {
                Spacer()
                
                Image("nv")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
            }
        } else {
            VStack {
                ProgressView(value: progress, total: 1.0) {
                    HStack {
                        Image(systemName: "megaphone")
                        Text("打卡进度 \(checkinsCount) / \(checkins.count)")
                    }
                    .font(.callout)
                    .foregroundColor(.primary.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                .animation(.default, value: progress)
                
                ForEach(checkins) { checkin in
                    CheckInRow(showingAlert: $showingAlert, wantToCheckin: $wantToCheckin, checkin: checkin)
                        .padding(.horizontal)
    //                CountDownRow(showingAlert: $showingAlert, countdown: checkin)
    //                    .onTapGesture {
    //                        showSheet = true
    //                        vm.selectedCheckIn = checkin
    //                    }
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    for checkin in checkins {
                        if canCheckin(checkin: checkin) {
                            checkin.isCheckin = false
                        }
                    }
                    
                    print("init checkin's isCheckin success in CheckInView")
                    
                    try? moc.save()
                }
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
