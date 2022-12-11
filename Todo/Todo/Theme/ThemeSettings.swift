//
//  ThemeSettings.swift
//  Todo
//
//  Created by DoubleShy0N on 2022/12/11.
//

import SwiftUI

// MARK: - THEME CLASS
final public class ThemeSettings: ObservableObject {
    @Published public var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(themeSettings, forKey: "Theme")
        }
    }
    
    private init() {}
    public static let shared = ThemeSettings()
}
