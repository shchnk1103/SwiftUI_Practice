//
//  RadialView.swift
//  RadialLayoutWithGestures
//
//  Created by DoubleShy0N on 2023/7/26.
//

import SwiftUI

/// Custom View
struct RadialLayout<Content: View, Item: RandomAccessCollection, ID: Hashable>: View where Item.Element: Identifiable {
    /// Additionally Returning Index and View Size
    var content: (Item.Element, Int, CGFloat) -> Content
    var keyPathID: KeyPath<Item.Element, ID>
    var items: Item
    /// View Properties
    var spacing: CGFloat?
    var onIndexChange: (Int) -> ()
    
    init(id: KeyPath<Item.Element, ID>, @ViewBuilder content: @escaping (Item.Element, Int, CGFloat) -> Content, items: Item, spacing: CGFloat? = nil, onIndexChange: @escaping (Int) -> ()) {
        self.content = content
        self.keyPathID = id
        self.items = items
        self.spacing = spacing
        self.onIndexChange = onIndexChange
    }
    
    /// Gesture Properties
    @State private var dragRotation: Angle = .zero
    @State private var lastDragRotation: Angle = .zero
    @State private var activeIndex: Int = 0
    
    var body: some View {
        GeometryReader(content: { geometry in
            let size = geometry.size // -> CGSize
            let width = size.width // iphone width
            let count = CGFloat(items.count) // colors.count (10)
            /// Applying Spacing
            let spacing: CGFloat = spacing ?? 0
            /// ViewSize in the Radial Layout is Calculated by the Total Count
            let viewSize = (width - spacing) / (count / 2)
            
            ZStack(content: {
                ForEach(items, id: keyPathID) { item in
                    let index = fetchIndex(item)
                    let rotation = (CGFloat(index) / count) * 360.0
                    
                    content(item, index, viewSize)
                        .rotationEffect(.init(degrees: 90))
                        .rotationEffect(.init(degrees: -rotation))
                        .rotationEffect(-dragRotation)
                        .frame(width: viewSize, height: viewSize)
                        .offset(x: (width - viewSize) / 2)
                        .rotationEffect(.init(degrees: -90))
                        .rotationEffect(.init(degrees: rotation))
                }
            })
            .frame(width: width, height: width)
            .contentShape(.rect)
            .rotationEffect(dragRotation)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let translateX = value.translation.width
                        let progress = translateX / (viewSize * 2)
                        let rotationFraction = 360.0 / count
                        
                        dragRotation = .init(degrees: (rotationFraction * progress) + lastDragRotation.degrees)
                        calculateIndex(count)
                    })
                    .onEnded({ value in
                        let velocityX = value.velocity.width / 15
                        let translateX = value.translation.width + velocityX
                        let progress = (translateX / (viewSize * 2)).rounded()
                        let rotationFraction = 360.0 / count
                        
                        withAnimation(.smooth) {
                            dragRotation = .init(degrees: (rotationFraction * progress) + lastDragRotation.degrees)
                        }
                        
                        lastDragRotation = dragRotation
                        calculateIndex(count)
                    })
            )
        })
    }
    
    /// Calculate the Center Top Index
    func calculateIndex(_ count: CGFloat) {
        var activeIndex = (dragRotation.degrees / 360.0 * count).rounded().truncatingRemainder(dividingBy: count)
        
        activeIndex = activeIndex == 0 ? 0 : (activeIndex < 0 ? -activeIndex : count - activeIndex)
        self.activeIndex = Int(activeIndex)
        
        /// Notifying the View
        onIndexChange(self.activeIndex)
    }
    
    /// Fetching Item Index
    func fetchIndex(_ item: Item.Element) -> Int {
        if let index = items.firstIndex(where: { $0.id == item.id }) as? Int {
            return index
        }
        
        return 0
    }
}

#Preview {
    ContentView()
}
