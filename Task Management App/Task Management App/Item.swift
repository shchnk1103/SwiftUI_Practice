//
//  Item.swift
//  Task Management App
//
//  Created by DoubleShy0N on 2023/7/20.
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
