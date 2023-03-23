//
//  TestView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/14.
//

import SwiftUI

struct TestView: View {
    @State private var headerOpacity: Double = 1.0
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: 0) {
                // Header
                Color.red
                    .frame(height: getHeaderHeightFor(offset: scrollOffset))
                    .frame(maxWidth: .infinity)
                    .background(Color(.white).opacity(Double((100 + scrollOffset) / 200.0)))
                    .overlay {
                        Text("\(scrollOffset)")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                
                // Content
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(0..<50) { index in
                            HStack {
                                Circle()
                                    .fill(Color.blue.opacity(0.5))
                                    .frame(width: 50, height: 50)
                                Text("Tweet \(index)")
                                    .font(.headline)
                                Spacer()
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            }
                        }
                    }
                    .overlay(content: {
                        GeometryReader { geo in
                            Color.clear
                                .preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .named("scroll")).minY)
                        }
                    })
                }
                .background(Color.white)
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UIScrollView.appearance().backgroundColor = .clear
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }
    
    private func getHeaderHeightFor(offset: CGFloat) -> CGFloat {
        let minHeight: CGFloat = 0
        let maxHeight: CGFloat = 50
        
        // 限制偏移量的范围
        let scrollOffset = min(max(offset, -maxHeight), 0)
        let height: CGFloat = maxHeight + scrollOffset
        return height >= minHeight ? height : minHeight
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
