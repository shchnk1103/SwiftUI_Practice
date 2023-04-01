//
//  TabModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import Foundation
import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var icon: String
    var tab: Tab
}

enum Tab: String {
    case home
    case search
    case me
}

var tabItems = [
    TabItem(icon: "house", tab: .home),
    TabItem(icon: "plus.circle", tab: .search),
    TabItem(icon: "person", tab: .me)
]

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
