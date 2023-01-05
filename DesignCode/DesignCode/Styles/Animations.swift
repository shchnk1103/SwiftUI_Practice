//
//  Animations.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/5.
//

import SwiftUI

extension Animation {
    static let openCard = Animation.spring(response: 0.5, dampingFraction: 0.7)
    static let closeCard = Animation.spring(response: 0.6, dampingFraction: 0.9)
}
