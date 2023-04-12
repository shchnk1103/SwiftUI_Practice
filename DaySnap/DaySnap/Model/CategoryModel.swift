//
//  CategoryModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/11.
//

import Foundation

struct Category: Identifiable, Hashable {
    var id: Int
    var name: String
    var icon: String
}

var categories = [
    Category(id: 1, name: "默认", icon: "list.bullet"),
    Category(id: 2, name: "Love", icon: "heart.circle"),
    Category(id: 3, name: "学习", icon: "book.circle.fill")
]
