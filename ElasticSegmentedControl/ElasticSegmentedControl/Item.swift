//
//  Item.swift
//  ElasticSegmentedControl
//
//  Created by DoubleShy0N on 2024/3/8.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
