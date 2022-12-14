//
//  MainTabView.swift
//  TwitterClone
//
//  Created by DoubleShy0N on 2022/12/14.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectIndex = 0
    
    var body: some View {
        TabView(selection: $selectIndex) {
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
                .onTapGesture {
                    self.selectIndex = 0
                }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onTapGesture {
                    self.selectIndex = 1
                }
                .tag(1)
            
            NotificationsView()
                .tabItem {
                    Image(systemName: "bell")
                }
                .onTapGesture {
                    self.selectIndex = 2
                }
                .tag(2)
            
            MessagesView()
                .tabItem {
                    Image(systemName: "envelope")
                }
                .onTapGesture {
                    self.selectIndex = 3
                }
                .tag(3)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
