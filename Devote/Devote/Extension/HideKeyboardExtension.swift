//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by 沈晨凯 on 2022/11/25.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
