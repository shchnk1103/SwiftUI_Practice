//
//  ContentView.swift
//  Animated Carousel Slider With Paging Control
//
//  Created by DoubleShy0N on 2023/9/21.
//

import SwiftUI

struct ContentView: View {
    /// Properties
    @State private var items: [Item] = [
        .init(color: .red, title: "World Clock", subTitle: "View the time in multiple cities around the world."),
        .init(color: .blue, title: "City Digital", subTitle: "Add a clock for a city to check the time at that location."),
        .init(color: .green, title: "City Analouge", subTitle: "Add a clock for a city to check the time at that location."),
        .init(color: .yellow, title: "Next Alarm", subTitle: "Display upcoming alarm.")
    ]
    
    var body: some View {
        CustomPagingSlider(data: $items) { $item in
            /// Content View
            RoundedRectangle(cornerRadius: 15)
                .fill(item.color.gradient)
                .frame(width: 150, height: 120)
        } titleContent: { $item in
            /// Title View
            VStack(spacing: 5, content: {
                Text(item.title)
                    .font(.largeTitle.bold())
                
                Text(item.subTitle)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .frame(height: 45)
            })
            .padding(.bottom, 35)
        }
        .safeAreaPadding([.top, .horizontal], 35)
    }
}

#Preview {
    ContentView()
}
