//
//  CategoryModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/11.
//

import Foundation

struct Category: Identifiable, Hashable, Codable {
    var id: Int
    var name: String
    var icon: String
}

var categories = [
    Category(id: 0, name: "默认", icon: "list.bullet"),
    Category(id: 1, name: "Love", icon: "heart.circle"),
    Category(id: 2, name: "学习", icon: "book.circle.fill")
]

struct SFSymbol: Identifiable, Hashable {
    var id: Int
    var name: String
}

var sfSymbols = [
    SFSymbol(id: 0, name: "pencil"),
    SFSymbol(id: 1, name: "paperplane"),
    SFSymbol(id: 2, name: "doc.plaintext"),
    SFSymbol(id: 3, name: "terminal"),
    SFSymbol(id: 4, name: "note")
]
