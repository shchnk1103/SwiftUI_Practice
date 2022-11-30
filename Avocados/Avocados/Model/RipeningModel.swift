//
//  RipeningModel.swift
//  Avocados
//
//  Created by 沈晨凯 on 2022/11/30.
//

import SwiftUI

struct Ripening: Identifiable {
    let id = UUID()
    let image: String
    let stage: String
    let title: String
    let description: String
    let ripeness: String
    let instruction: String
}
