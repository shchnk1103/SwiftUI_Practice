//
//  LockType.swift
//  CustomLockScreen
//
//  Created by DoubleShy0N on 2023/10/21.
//

import Foundation

/// Lock Type
enum LockType: String {
    case biometric = "Bio Metric Auth"
    case number = "Custom Number Lock"
    case both = "First preference will be biometric, and if it's not available, it will go for number lock."
}
