//
//  Shop.swift
//  Touchdown
//
//  Created by 沈晨凯 on 2022/11/23.
//

import Foundation

class Shop: ObservableObject {
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? = nil
}
