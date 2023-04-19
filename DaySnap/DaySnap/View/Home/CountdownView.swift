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
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var filter: CountDownFilter
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \CountDown.isPinned, ascending: false),
        NSSortDescriptor(keyPath: \CountDown.name, ascending: true),
        NSSortDescriptor(keyPath: \CountDown.remainingDays, ascending: true)
    ]) var countdowns: FetchedResults<CountDown>
    
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
            ForEach(countdowns.filter({ countdown in
                if filter.category == "默认" || filter.category == "" {
                    return true
                }
                return countdown.category == filter.category
            })) { countdown in
                CountDownRow(showingAlert: $showingAlert, countdown: countdown)
                    .onTapGesture {
                        showSheet = true
                        vm.selectedCountdown = countdown
                    }
            }
            .sheet(isPresented: $showSheet) {
                EditView(countdown: vm.selectedCountdown!)
            }
            .onAppear {
                DispatchQueue.main.async {
                    for countdown in countdowns {
                        countdown.remainingDays = calRemainingDays(targetDay: countdown.targetDate ?? Date())
                    }
                    
                    print("init countdown's remainingDays success in CountdownView")
                    
                    try? moc.save()
                }
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
