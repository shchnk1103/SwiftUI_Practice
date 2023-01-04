//
//  ContentView.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/2.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .explore:
                    AccountView()
                case .notification:
                    AccountView()
                case .library:
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            TabBarView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
