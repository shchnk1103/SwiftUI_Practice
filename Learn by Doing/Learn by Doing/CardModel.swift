//
//  CardModel.swift
//  Learn by Doing
//
//  Created by 沈晨凯 on 2022/11/28.
//

import SwiftUI

// MARK: - CARD MODEL
struct Card: Identifiable {
    let id = UUID()
    let title: String
    let headline: String
    let imageName: String
    let callToAction: String
    let message: String
    let gradientColors: [Color]
}
