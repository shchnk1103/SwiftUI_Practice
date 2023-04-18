//
//  WeatherAttributionView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/17.
//

import SwiftUI

struct WeatherAttributionView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showAttribution: Bool
    @State private var appear: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.15)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Text("由  Weather 提供数据")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .padding()
                
                Link(destination: URL(string: "https://weatherkit.apple.com/legal-attribution.html")!) {
                    Text("法律来源链接 ->")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke()
            )
            .frame(height: 410)
            .frame(maxWidth: 350)
            .padding(.horizontal, 30)
            .offset(y: appear ? 0 : 1000)
        }
        .zIndex(9)
        .onTapGesture {
            showAttribution = false
        }
        .onAppear {
            withAnimation(.default.delay(0.3)) {
                appear = true
            }
        }
    }
}

struct WeatherAttributionView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAttributionView(showAttribution: .constant(true))
    }
}
