//
//  RectKey.swift
//  TelegramDarkModeAnimation
//
//  Created by DoubleShy0N on 2023/9/28.
//

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
