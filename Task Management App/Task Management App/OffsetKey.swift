//
//  OffsetKey.swift
//  Task Management App
//
//  Created by DoubleShy0N on 2023/7/21.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
