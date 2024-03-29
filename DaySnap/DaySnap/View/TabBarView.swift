//
//  TabBarView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.colorScheme) var colorScheme
    // 自定义颜色
    @AppStorage("colorCustom") var colorCustom: String = ""
    // Tab Bar Color
    @AppStorage("colorTabBar") var colorTabBar: String = ""
    
    @State private var tabWidth: CGFloat = 0
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        GeometryReader { geo in
            let hasHomeIndicator = geo.safeAreaInsets.bottom - 88 > 20
            
            HStack {
                buttons
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 16)
            .frame(height: hasHomeIndicator ? 80 : 62, alignment: .top)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: hasHomeIndicator ? 34 : 0, style: .continuous))
            .background( background )
            .overlay { overlay }
            .strokeStyle(cornerRadius: 34)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button {
                selectedTab = item.tab
            } label: {
                Image(systemName: item.icon)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .font(.title)
            .foregroundColor(
                selectedTab == item.tab
                ? (colorTabBar == ""
                   ? stringToColor(color: colorCustom)
                   : stringToColor(color: colorTabBar))
                : .secondary
            )
            //.blendMode(selectedTab == item.tab ? .overlay : .normal)
            .overlay {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: TabPreferenceKey.self, value: geo.size.width)
                }
            }
            .onPreferenceChange(TabPreferenceKey.self) { value in
                tabWidth = value
            }
        }
    }
    
    var background: some View {
        HStack(spacing: 0) {
            if selectedTab == .search { Spacer() }
            if selectedTab == .me { Spacer() }
            
            Circle()
                .fill(
                    colorTabBar == ""
                     ? stringToColor(color: colorCustom)
                     : stringToColor(color: colorTabBar)
                )
                .frame(width: tabWidth)
            
            if selectedTab == .home { Spacer() }
            if selectedTab == .search { Spacer() }
        }
        .padding(.horizontal, 15)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
    }
    
    var overlay: some View {
        HStack(spacing: 0) {
            if selectedTab == .search { Spacer() }
            if selectedTab == .me { Spacer() }
            
            Rectangle()
                .foregroundColor(
                    colorTabBar == ""
                     ? stringToColor(color: colorCustom)
                     : stringToColor(color: colorTabBar)
                )
                .frame(width: 28, height: 4)
                .cornerRadius(3)
                .frame(width: tabWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            
            if selectedTab == .home { Spacer() }
            if selectedTab == .search { Spacer() }
        }
        .padding(.horizontal, 15)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(.home))
    }
}
