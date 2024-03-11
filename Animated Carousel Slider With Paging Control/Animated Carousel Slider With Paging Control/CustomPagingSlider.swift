//
//  CustomPagingSlider.swift
//  Animated Carousel Slider With Paging Control
//
//  Created by DoubleShy0N on 2023/9/21.
//

import SwiftUI

struct Item: Identifiable {
    private(set) var id: UUID = .init()
    var color: Color
    var title: String
    var subTitle: String
}

struct CustomPagingSlider<Content: View, TitleContent: View, Item: RandomAccessCollection>: View where Item: MutableCollection, Item.Element: Identifiable {
    /// Properties
    var showIndicator: ScrollIndicatorVisibility = .hidden
    var showPagingControl: Bool = true
    var pagingControlSpacing: CGFloat = 20
    var spacing: CGFloat = 10
    var titleScrollSpeed: CGFloat = 0.6
    @State private var activeID: UUID?
    
    @Binding var data: Item
    @ViewBuilder var content: (Binding<Item.Element>) -> Content
    @ViewBuilder var titleContent: (Binding<Item.Element>) -> TitleContent
    
    var body: some View {
        VStack(spacing: pagingControlSpacing, content: {
            ScrollView(.horizontal) {
                HStack(spacing: spacing, content: {
                    ForEach($data) { item in
                        VStack(spacing: 0, content: {
                            titleContent(item)
                                .frame(maxWidth: .infinity)
                                .visualEffect { content, geometryProxy in
                                    content
                                        .offset(x: scrollOffset(geometryProxy))
                                }
                            
                            content(item)
                        })
                        .containerRelativeFrame(.horizontal)
                    }
                })
                /// Adding Paging
                .scrollTargetLayout()
            }
            .scrollIndicators(showIndicator)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeID)
            
            if showPagingControl {
                PagingControl(numberOfPages: data.count, activePage: activePage) { value in
                    if let index = value as? Item.Index, data.indices.contains(index) {
                        if let id = data[index].id as? UUID {
                            withAnimation(.snappy(duration: 0.35, extraBounce: 0)) {
                                activeID = id
                            }
                        }
                    }
                }
            }
        })
    }
    
    var activePage: Int {
        if let index = data.firstIndex(where: { $0.id as? UUID == activeID }) as? Int {
            return index
        }
        
        return 0
    }
    
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.bounds(of: .scrollView)?.minX ?? 0
        
        return -minX * min(titleScrollSpeed, 1)
    }
}

/// Paging Control
struct PagingControl: UIViewRepresentable {
    var numberOfPages: Int
    var activePage: Int
    var onPageChange: (Int) -> ()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onPageChange: onPageChange)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let view = UIPageControl()
        view.currentPage = activePage
        view.numberOfPages = numberOfPages
        view.backgroundStyle = .prominent
        view.currentPageIndicatorTintColor = UIColor(Color.primary)
        view.pageIndicatorTintColor = UIColor.placeholderText
        view.addTarget(context.coordinator, action: #selector(Coordinator.onPageUpdate(control:)), for: .valueChanged)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.numberOfPages = numberOfPages
        uiView.currentPage = activePage
    }
    
    class Coordinator: NSObject {
        var onPageChange: (Int) -> ()
        init(onPageChange: @escaping (Int) -> Void) {
            self.onPageChange = onPageChange
        }
        
        @objc
        func onPageUpdate(control: UIPageControl) {
            onPageChange(control.currentPage)
        }
    }
}

#Preview {
    ContentView()
}
