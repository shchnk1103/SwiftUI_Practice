//
//  HomeView.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/4.
//

import SwiftUI

struct HomeView: View {
    @State private var hasScrolled: Bool = false
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                Color.clear.preference(key: ScrollPreferenceKeys.self, value: geometry.frame(in: .named("scroll")).minY)
            }
            .frame(height: 0)
            
            FeaturedItem()
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollPreferenceKeys.self, perform: { value in
            withAnimation(.easeInOut) {                
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
        .safeAreaInset(edge: .top, content: {
            Color.clear.frame(height: 70)
        })
        .overlay {
            NavigationBarView(title: "Featured", hasScrolled: $hasScrolled)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
