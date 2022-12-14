//
//  TabBarView.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/3.
//

import SwiftUI

struct TabBarView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @State private var color: Color = .teal
    @State private var tabItemWidth: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let hasHomeIndicator = geometry.safeAreaInsets.bottom - 88 > 20
            
            HStack {
                buttons
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: hasHomeIndicator ? 88 : 62, alignment: .top)
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: hasHomeIndicator ? 34 : 0, style: .continuous)
            )
            .background(
                background
            )
            .overlay(
                overlay
            )
            .strokeStyle(cornerRadius: hasHomeIndicator ? 34 : 0)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    color = item.color
                    selectedTab = item.tab
                }
            } label: {
                VStack(spacing: 0) {
                    Image(systemName: item.icon)
                        .symbolVariant(.fill)
                        .font(.body.bold())
                        .frame(width: 44, height: 29)
                    
                    Text(item.text)
                        .font(.caption2)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
            .blendMode(selectedTab == item.tab ? .overlay : .normal)
            .overlay {
                GeometryReader { geometry in
                    Color.clear.preference(key: TabPreferenceKey.self, value: geometry.size.width)
                }
            }
            .onPreferenceChange(TabPreferenceKey.self) { value in
                tabItemWidth = value
            }
        }
    }
    
    var background: some View {
        HStack {
            if selectedTab == .explore { Spacer() }
            if selectedTab == .notification {
                Spacer()
                Spacer()
            }
            if selectedTab == .library { Spacer() }
            Circle().fill(color).frame(width: tabItemWidth)
            if selectedTab == .home { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .notification { Spacer() }
        }
        .padding(.horizontal, 8)
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .explore { Spacer() }
            if selectedTab == .notification {
                Spacer()
                Spacer()
            }
            if selectedTab == .library { Spacer() }
            Rectangle()
                .fill(color)
                .frame(width: 28, height: 5)
                .cornerRadius(3)
                .frame(width: tabItemWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            if selectedTab == .home { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .notification { Spacer() }
        }
        .padding(.horizontal, 8)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
