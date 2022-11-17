//
//  FruitModel.swift
//  Fructus
//
//  Created by 沈晨凯 on 2022/11/9.
//

import SwiftUI

struct Fruit: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
    var description: String
    var nutrition: [String]
}
