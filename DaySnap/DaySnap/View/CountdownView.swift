//
//  CountdownView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/6.
//

import SwiftUI

struct CountdownView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countdowns: FetchedResults<CountDown>
    @EnvironmentObject var vm: HomeViewModel
    
    @Binding var showingAlert: Bool
    @State private var showSheet: Bool = false
    
    var body: some View {
        if countdowns.isEmpty {
            VStack {
                Spacer()
                
                Image("nan")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
            }
        } else {
            ForEach(countdowns) { countdown in
                CountDownRow(showingAlert: $showingAlert, countdown: countdown)
                    .onTapGesture {
                        showSheet = true
                        vm.selectedCountdown = countdown
                    }
            }
            .sheet(isPresented: $showSheet) {
                EditView(countdown: vm.selectedCountdown!)
            }
        }
    }
    
    // MARK: functions
    // 暂时不用
    func deleteCountdown(at offsets: IndexSet) {
        for offset in offsets {
            let countdown = countdowns[offset]
            moc.delete(countdown)
        }
        
        try? moc.save()
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(showingAlert: .constant(false))
    }
}
