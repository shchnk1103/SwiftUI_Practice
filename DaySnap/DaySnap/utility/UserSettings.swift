//
//  UserSettings.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/26.
//

import Foundation
import SwiftUI

class UserSettings {
    @UserDefaults("selectedColor", defaultValue: Color.primary, store: .standard)
    static var selectedColor: Color
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let store: UserDefaults

    init(_ key: String, defaultValue: T, store: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.store = store
    }

    var wrappedValue: T {
        get {
            return store.object(forKey: key) as? T ?? defaultValue
        }

        set {
            store.set(newValue, forKey: key)
        }
    }
}
