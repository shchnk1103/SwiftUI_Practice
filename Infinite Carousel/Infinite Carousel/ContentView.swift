//
//  ContentView.swift
//  Infinite Carousel
//
//  Created by DoubleShy0N on 2023/7/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Infinite Carousel")
        }
    }
}

#Preview {
    ContentView()
}
