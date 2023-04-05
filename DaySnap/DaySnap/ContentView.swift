//
//  ContentView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @EnvironmentObject var countdownStore: CountdownStore
    @EnvironmentObject var checkinStore: CheckinStore
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear
            
            switch selectedTab {
            case .home:
                HomeView()
            case .search:
                AddView()
//                test_2()
            case .me:
                MeView()
            }
            
            TabBarView()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear.frame(height: 88)
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    static let checkinStore = CheckinStore()
    
    static var previews: some View {
        ContentView()
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
    }
}
