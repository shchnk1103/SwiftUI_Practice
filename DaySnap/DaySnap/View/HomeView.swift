//
//  HomeView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var countdownStore: CountdownStore
    @EnvironmentObject var checkinStore: CheckinStore
    @StateObject private var vm = HomeViewModel()
    @State private var isCountdownButtonClicked = true
    @State private var wantToCheckin: Bool = false
    @State private var offset: CGFloat = 0
    @State private var startOffset: CGFloat = 0
    @State private var scrollViewHeight: CGFloat = 0
    @State private var switchOffset: CGFloat = 0
    @State private var switchHeight: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                HeaderView()
                    .frame(height: 120)
                    .padding()
                    .offset(getOffset())
                    .opacity(getOpacity())
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
                
                VStack(alignment: .leading, spacing: 0) {
                    SwitchView(isCountdownButtonClicked: $isCountdownButtonClicked)
                        .padding()
                        .frame(height: 60)
                        .offset(y: offset > 0 ? (offset <= switchOffset ? -offset : -switchOffset) : 0)
                    
                    Text(isCountdownButtonClicked ? "所有倒数日" : "所有打卡项目")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding()
                        .offset(y: offset > 0 ? (offset <= switchOffset ? -offset : -switchOffset) : 0)
                }
                .overlay {
                    GeometryReader { geo -> Color in
                        let maxY = geo.frame(in: .global).maxY
                        let minY = geo.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                let window = UIWindow(windowScene: windowScene)
                                let safeAreaInsets = window.safeAreaInsets.top
                                switchHeight = maxY - minY + safeAreaInsets - 12
                            }
                        }
                        
                        return Color.clear
                    }
                }
            }
            .zIndex(1)
            .padding(.bottom, offset < switchHeight ? -offset : -switchHeight)
            .background(Color.white)
            .overlay {
                GeometryReader { geo -> Color in
                    let height = geo.frame(in: .global).maxY
                    
                    DispatchQueue.main.async {
                        if scrollViewHeight == 0 {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                let window = UIWindow(windowScene: windowScene)
                                let safeAreaInsets = window.safeAreaInsets.top
                                scrollViewHeight = height - safeAreaInsets
                            }
                        }
                    }
                    
                    return Color.clear
                }
            }
            
            // Content
            ScrollView(.vertical, showsIndicators: false) {
                ItemListView(flag: $isCountdownButtonClicked, wantToCheckin: $wantToCheckin)
                    .environmentObject(vm)
                    .navigationTitle("首页")
                    .toolbar(.hidden, for: .automatic)
                    .onAppear {
                        isCountdownButtonClicked = false
                        isCountdownButtonClicked = true
                    }
                    .frame(minHeight: 800, maxHeight: .infinity)
                    .padding(.top, scrollViewHeight)
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
            
            // 弹窗提醒
            if wantToCheckin {
                CheckinView(flag: $wantToCheckin)
                    .environmentObject(vm)
                    .zIndex(2)
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UIScrollView.appearance().backgroundColor = .clear
        }
    }
    
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
    static let countdownStore = CountdownStore()
    static let checkinStore = CheckinStore()
    
    static var previews: some View {
        HomeView()
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
    }
}
