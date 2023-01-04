//
//  TabModel.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/4.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
}

var tabItems = [
    TabItem(text: "Learn", icon: "house", tab: .home),
    TabItem(text: "Explore", icon: "magnifyingglass", tab: .explore),
    TabItem(text: "Notifications", icon: "bell", tab: .notification),
    TabItem(text: "Library", icon: "rectangle.stack", tab: .library)
]

enum Tab: String {
    case home
    case explore
    case notification
    case library
}
