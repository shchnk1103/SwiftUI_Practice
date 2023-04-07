//
//  HomeView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("flag") var flag: Bool = true
    @StateObject private var vm = HomeViewModel()
    
    @State private var wantToCheckin: Bool = false
    @State private var showingAlert: Bool = false
    @State private var offset: CGFloat = 0
    @State private var startOffset: CGFloat = 0
    @State private var scrollPaddingTop: CGFloat = 0
    @State private var switchOffset: CGFloat = 0
    @State private var switchHeight: CGFloat = 0
    @State private var textHeight: CGFloat = 0
    @State private var pathCountdown: [CountDown] = []
    @State private var pathCheckin: [CheckIn] = []
    
    var body: some View {
        ZStack(alignment: .top) {

            VStack(alignment: .leading, spacing: 0) {
                
                header
                
                switchCenter
            }
            .zIndex(1)
            .padding(.bottom, offset < switchHeight ? -offset : -(switchHeight + textHeight - 15))
            .background(.regularMaterial)
            .shadow(radius: 4)
            // GeometryReader
            .overlay { overlay }
            
            // MARK: Content
            ScrollView(.vertical, showsIndicators: false) {
                itemList
            }
            
            // 弹窗提醒 - 打卡
            if wantToCheckin {
                ToCheckinView(flag: $wantToCheckin)
                    .zIndex(2)
                    .environmentObject(vm)
            }
            
            // 弹窗提醒 - 删除
            if showingAlert {
                DeleteView(showingAlert: $showingAlert)
                    .environmentObject(vm)
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UIScrollView.appearance().backgroundColor = .clear
        }
    }
    
    var header: some View {
        HeaderView()
            .padding(.horizontal)
            .background(colorScheme == .dark ? .black : .white, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(colorScheme == .dark ? .white.opacity(0.5) : .white, lineWidth: 1)
            }
            .shadow(
                color: colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.25),
                radius: 12, x: 0, y: 0
            )
            .padding()
            .offset(getOffset())
            .opacity(getOpacity())
            // GeometryReader
            .overlay {
                GeometryReader { geo -> Color in
                    let maxY = geo.frame(in: .global).maxY
                    
                    DispatchQueue.main.async {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            let window = UIWindow(windowScene: windowScene)
                            let safeAreaInsets = window.safeAreaInsets.top
                            switchOffset = maxY - safeAreaInsets
                        }
                    }
                    
                    return Color.clear
                }
            }
    }
    
    var switchCenter: some View {
        VStack(alignment: .leading, spacing: 0) {
            SwitchView()
                .padding()
                .frame(height: 60)
                .offset(y: offset > 0 ? (offset <= switchOffset ? -offset : -switchOffset) : 0)
            
            Text(flag ? "所有倒数日" : "所有打卡项目")
                .font(.body)
                .foregroundColor(.secondary)
                .padding()
                .offset(y: offset > 0 ? (offset <= switchOffset ? -offset : -switchOffset) : 0)
                .opacity(getOpacity())
                .animation(.easeOut, value: flag)
                .overlay {
                    GeometryReader { geo -> Color in
                        let height = geo.size.height
                        
                        DispatchQueue.main.async {
                            textHeight = height
                        }
                        
                        return Color.clear
                    }
                }
        }
        // GeometryReader
        .overlay {
            GeometryReader { geo -> Color in
                let height = geo.size.height
                
                DispatchQueue.main.async {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let window = UIWindow(windowScene: windowScene)
                        let safeAreaInsets = window.safeAreaInsets.top
                        switchHeight = height + safeAreaInsets
                    }
                }
                
                return Color.clear
            }
        }
    }
    
    var overlay: some View {
        GeometryReader { geo -> Color in
            let height = geo.size.height
            
            DispatchQueue.main.async {
                if scrollPaddingTop == 0 {
                    scrollPaddingTop = height
                }
            }
            
            return Color.clear
        }
    }
    
    var itemList: some View {
        ItemListView(wantToCheckin: $wantToCheckin, showingAlert: $showingAlert)
            .environmentObject(vm)
            .frame(maxHeight: .infinity)
            .padding(.top, scrollPaddingTop)
            // GeometryReader
            .overlay(alignment: .top) {
                GeometryReader { geo -> Color in
                    let minY = geo.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        if startOffset == 0 {
                            startOffset = minY
                        }
                        
                        offset = startOffset - minY
                    }
                    
                    return Color.clear
                }
                .frame(width: 0, height: 0)
            }
    }
    
    
    // MARK: fuc
    
    private func getOffset() -> CGSize {
        var size: CGSize = .zero
        size.width = 0
        size.height = offset > 0 ? -offset : 0
        
        return size
    }
    
    private func getOpacity() -> Double {
        var opacity: Double = 0
        
        if offset > 0 {
            opacity = 1.0 - min(abs(getOffset().height / 100), 1.0)
        } else if offset > 120 {
            opacity = 0
        } else {
            opacity = 1
        }
        
        return opacity
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
