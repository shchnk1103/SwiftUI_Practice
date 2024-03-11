//
//  WindowSharedModel.swift
//  SheetAnimation
//
//  Created by DoubleShy0N on 2023/10/13.
//

import SwiftUI

@Observable
class WindowSharedModel {
    var sourceRect: CGRect = .zero
    var previousSourceRect: CGRect = .zero
    var hideNativeView: Bool = false
    var selectedProfile: Profile?
    
    func reset() {
        sourceRect = .zero
        previousSourceRect = .zero
        hideNativeView = false
        selectedProfile = nil
    }
}
