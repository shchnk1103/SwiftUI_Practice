//
//  CDCountDown+Extensions.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2024/1/4.
//

import SwiftUI

extension CDCountDown {
    var displayName: String {
        guard let name, !name.isEmpty else { return "Untitled CountDown" }
        return name
    }
    
    static var preview: CDCountDown {
        let result = DataController.preview
        let viewContext = result.container.viewContext
        let countdown = CDCountDown(context: viewContext)
        countdown.name = "TEST 101"
        return countdown
    }
}
