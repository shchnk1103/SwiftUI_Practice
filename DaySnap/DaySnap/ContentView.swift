//
//  ContentView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @EnvironmentObject var countdownStore: CountdownStore
    @EnvironmentObject var checkinStore: CheckinStore
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear
            
            switch selectedTab {
            case .home:
                HomeView()
            case .search:
                AddView()
            case .me:
                MeView()
            }
            
            TabBarView(selectedTab: $selectedTab)
                .padding(.bottom, 20)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
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
