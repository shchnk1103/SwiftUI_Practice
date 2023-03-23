//
//  InputLimit.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/13.
//

import Foundation

extension String {
    var isEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F,  // Emoticons
                 0x1F300...0x1F5FF,  // Miscellaneous Symbols and Pictographs
                 0x1F680...0x1F6FF,  // Transport and Map
                 0x2600...0x26FF,    // Miscellaneous Symbols
                 0x2700...0x27BF,    // Dingbats
                 0xFE00...0xFE0F,    // Variation Selectors
                 0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs
                 127000...127600,    // Other symbols
                 65024...65039,      // Variation selector
                 9100...9300,        // Misc items
                 8419,               // Music note
                 8252,               // Triangular flag
                 8265,               // Combining enclosing keycap
                 1757,               // Armenian emphasis mark
                 1758,               // Armenian exclamation mark
                 65039,              // Text style variant
                 8400...8447:        // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
}
