//
//  AnimalModel.swift
//  Africa
//
//  Created by 沈晨凯 on 2022/11/13.
//

import SwiftUI

struct Animal: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    let description: String
    let link: String
    let image: String
    let gallery: [String]
    let fact: [String]
}
