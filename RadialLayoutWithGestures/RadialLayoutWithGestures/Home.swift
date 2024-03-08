//
//  Home.swift
//  RadialLayoutWithGestures
//
//  Created by DoubleShy0N on 2023/7/26.
//

import SwiftUI

struct Home: View {
    /// Properties
    @State private var colors: [ColorValue] = [.red, .yellow, .green, .purple, .pink, .orange, .brown, .cyan, .indigo, .mint].compactMap { color -> ColorValue? in
        return .init(color: color)
    }
    @State private var activeIndex: Int = 0
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack {
                Text("Active Index: \(activeIndex)")
                
                Spacer(minLength: 0)
                
                RadialLayout(id: \.id, content: { colorValue, index, size in
                    /// Sample View
                    Circle()
                        .fill(colorValue.color.gradient)
                        .overlay {
                            Text("\(index)")
                                .fontWeight(.semibold)
                        }
                }, items: colors, spacing: 200) { index in
                    /// Updating Index
                    activeIndex = index
                }
                .padding(.horizontal, -100)
                .frame(width: geometry.size.width, height: geometry.size.width / 2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        .padding(15)
    }
}

#Preview {
    ContentView()
}
