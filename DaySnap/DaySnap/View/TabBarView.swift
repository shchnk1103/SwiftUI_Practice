//
//  TabBarView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            ForEach(tabItems) { item in
                Button {
                    selectedTab = item.tab
                } label: {
                    Image(systemName: item.icon)
                        .foregroundColor(selectedTab == item.tab ? Color.primary : Color.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.vertical, 20)
        .background(colorScheme == .dark ? .black : .white)
        .cornerRadius(50)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
        })
        .font(.title)
        .padding(.horizontal, 15)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(.home))
    }
}
