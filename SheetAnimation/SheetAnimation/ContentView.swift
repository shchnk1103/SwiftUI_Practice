//
//  ContentView.swift
//  SheetAnimation
//
//  Created by DoubleShy0N on 2023/10/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .navigationTitle("Chat App")
        }
    }
}

#Preview {
    ContentView()
}
