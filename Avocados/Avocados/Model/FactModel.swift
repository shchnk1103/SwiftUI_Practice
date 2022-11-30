//
//  FactModel.swift
//  Avocados
//
//  Created by 沈晨凯 on 2022/11/29.
//

import SwiftUI

struct Fact: Identifiable {
    let id = UUID()
    let image: String
    let content: String
}
