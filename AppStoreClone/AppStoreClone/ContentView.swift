//
//  ContentView.swift
//  AppStoreClone
//
//  Created by DoubleShy0N on 2023/1/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "doc.text.image")
                    Text("Today")
                }
            
            Text("Games")
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }
            
            Text("Apps")
                .tabItem {
                    Image(systemName: "square.stack.3d.up.fill")
                    Text("Apps")
                }
            
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
