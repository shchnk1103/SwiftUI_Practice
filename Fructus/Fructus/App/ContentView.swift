//
//  ContentView.swift
//  Fructus
//
//  Created by 沈晨凯 on 2022/11/9.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    var fruits: [Fruit] = fruitsData
    @State private var isShowSettings: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(fruits.shuffled()) { fruit in
                    NavigationLink(
                        destination: FruitDetailView(fruit: fruit)
                    ) {
                        FruitRowView(fruit: fruit)
                            .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Fruits")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        isShowSettings = true
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                    }) //: BUTTON
                    .sheet(isPresented: $isShowSettings, content: {
                        SettingsView()
                    })
            )
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
