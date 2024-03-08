//
//  MAnchorKey.swift
//  NavigationStackAnimation
//
//  Created by DoubleShy0N on 2023/7/24.
//

import SwiftUI

/// For reading the Source and Destination View Bounds for our Custom Matched Geometry Effect
struct MAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
