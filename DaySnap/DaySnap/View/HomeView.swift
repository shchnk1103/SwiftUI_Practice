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
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                HeaderView()
                    .frame(height: 120)
                    .offset(y: offsetY - 90 > 0 ? 0 : 1000)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                
                SwitchView(isCountdownButtonClicked: $isCountdownButtonClicked)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .frame(height: 60)
                    .offset(y: offsetY - 90 > 0 ? 0 : -160)
                
                Text(isCountdownButtonClicked ? "所有倒数日" : "所有打卡项目")
                    .font(.body)
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
                    .offset(y: offsetY - 90 > 0 ? 0 : -160)
                
                // Content
                ScrollView(.vertical, showsIndicators: false) {
                    ItemListView(flag: $isCountdownButtonClicked, wantToCheckin: $wantToCheckin)
                        .environmentObject(vm)
                        .navigationTitle("首页")
                        .toolbar(.hidden, for: .automatic)
                        .safeAreaInset(edge: .bottom) {
                            Color.clear
                                .frame(height: 70)
                        }
                        .onAppear {
                            isCountdownButtonClicked = false
                            isCountdownButtonClicked = true
                        }
                        .frame(minHeight: 600, maxHeight: .infinity)
                        .overlay {
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: ScrollPositionPreferenceKey.self, value: geo.frame(in: .named("home")).minY)
                            }
                        }
                }
                .offset(y: offsetY - 90 > 0 ? 0 : -160)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .accentColor(.black)
            
            // 弹窗提醒
            if wantToCheckin {
                CheckinView(flag: $wantToCheckin)
                    .environmentObject(vm)
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UIScrollView.appearance().backgroundColor = .clear
        }
        .frame(minHeight: 600, maxHeight: .infinity)
        .coordinateSpace(name: "home")
        .onPreferenceChange(ScrollPositionPreferenceKey.self) { value in
            offsetY = value
        }
    }
    
    private func getHeaderHeightFor(offset: CGFloat) -> CGFloat {
        let minHeight: CGFloat = 0
        let maxHeight: CGFloat = 120
        
        // 限制偏移量的范围
        let scrollOffset = min(max(offset, -maxHeight), 0)
        let height: CGFloat = maxHeight + scrollOffset
        return height >= minHeight ? height : minHeight
    }
}

struct ScrollPositionPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
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
