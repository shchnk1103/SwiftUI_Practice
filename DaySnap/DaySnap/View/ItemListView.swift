//
//  ItemListView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct ItemListView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("flag") var flag: Bool = true
    @FetchRequest(sortDescriptors: []) var countdowns: FetchedResults<CountDown>
    
    @Binding var wantToCheckin: Bool
    @Binding var showingAlert: Bool
    
    var body: some View {
        VStack {
            if flag {
                CountdownView(showingAlert: $showingAlert)
            } else {
                CheckInView(showingAlert: $showingAlert, wantToCheckin: $wantToCheckin)
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                for countdown in countdowns {
                    countdown.remainingDays = calRemainingDays(targetDay: countdown.targetDate ?? Date())
                }
                
                try? moc.save()
            }
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static let vm = HomeViewModel()
    
    static var previews: some View {
        ItemListView(wantToCheckin: .constant(false), showingAlert: .constant(false))
            .environmentObject(vm)
    }
}
