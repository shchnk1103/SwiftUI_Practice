//
//  RecipeModel.swift
//  Avocados
//
//  Created by 沈晨凯 on 2022/11/29.
//

import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let headline: String
    let image: String
    let rating: Int
    let serves: Int
    let preparation: Int
    let cooking: Int
    let instructions: [String]
    let ingredients: [String]
}
