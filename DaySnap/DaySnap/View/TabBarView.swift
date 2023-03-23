//
//  TabBarView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            ForEach(tabItems) { item in
                Button {
                    selectedTab = item.tab
                } label: {
                    Image(systemName: item.icon)
                        .foregroundColor(selectedTab == item.tab ? Color.black : Color.black.opacity(0.3))
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.vertical, 20)
        .background(.white)
        .cornerRadius(50)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .stroke(Color.black, lineWidth: 1)
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
