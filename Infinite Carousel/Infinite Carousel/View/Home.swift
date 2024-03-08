//
//  Home.swift
//  Infinite Carousel
//
//  Created by DoubleShy0N on 2023/7/18.
//

import SwiftUI

struct Page: Identifiable, Hashable {
    var id: UUID = .init()
    var color: Color
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetX(_ addObserver: Bool, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .frame(maxWidth: .infinity)
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        
                        Color.clear
                            .preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self, perform: completion)
                    }
                }
            }
    }
}

struct PageControl: UIViewRepresentable {
    var totalPages: Int
    var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = totalPages
        control.currentPage = currentPage
        control.backgroundStyle = .prominent
        control.allowsContinuousInteraction = false
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = totalPages
        uiView.currentPage = currentPage
    }
}

struct Home: View {
    @State private var currentPage: String = ""
    @State private var listOfPages: [Page] = []
    
    @State private var fakedPages: [Page] = []
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            TabView(selection: $currentPage, content:  {
                ForEach(fakedPages) { page in
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .tag(page.id.uuidString)
                        // calculate
                        .offsetX(currentPage == page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(page)))
                            // coverting page offset into progress
                            let pageProgress = pageOffset / size.width
                            // infinite carousel logic
                            if -pageProgress < 1.0 {
                                // Moving to the last page
                                if fakedPages.indices.contains(fakedPages.count - 1) {
                                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                                }
                            }
                            
                            if -pageProgress > CGFloat(fakedPages.count - 1) {
                                // Moving to the first page
                                if fakedPages.indices.contains(1) {
                                    currentPage = fakedPages[1].id.uuidString
                                }
                            }
                        }
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(totalPages: listOfPages.count, currentPage: originalIndex(currentPage))
                    .offset(y: -15)
            }
        }
        .frame(height: 400)
        .onAppear {
            guard fakedPages.isEmpty else { return }
            
            for color in [Color.red, Color.blue, Color.black, Color.yellow, Color.brown] {
                listOfPages.append(.init(color: color))
            }
            
            fakedPages.append(contentsOf: listOfPages)
            
            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                currentPage = firstPage.id.uuidString
                
                // updating id
                firstPage.id = .init()
                lastPage.id = .init()
                
                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
        }
    }
    
    func fakeIndex(_ of: Page) -> Int {
        return fakedPages.firstIndex(of: of) ?? 0
    }
    
    func originalIndex(_ id: String) -> Int {
        return listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
}

#Preview {
    ContentView()
}
