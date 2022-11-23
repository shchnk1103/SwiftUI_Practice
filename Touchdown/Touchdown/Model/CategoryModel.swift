//
//  CategoryModel.swift
//  Touchdown
//
//  Created by 沈晨凯 on 2022/11/23.
//

import Foundation

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}
