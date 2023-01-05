//
//  PreferenceKeys.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/5.
//

import SwiftUI

struct ScrollPreferenceKeys: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
