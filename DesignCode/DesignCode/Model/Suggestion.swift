//
//  Suggestion.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/6.
//

import SwiftUI

struct Suggestion: Identifiable {
    let id = UUID()
    var text: String
}

var suggestions = [
    Suggestion(text: "SwiftUI"),
    Suggestion(text: "React"),
    Suggestion(text: "Design")
]
