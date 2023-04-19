//
//  DaySnapWidgetBundle.swift
//  DaySnapWidget
//
//  Created by DoubleShy0N on 2023/4/3.
//

import WidgetKit
import SwiftUI

@main
struct DaySnapWidgetBundle: WidgetBundle {
    var body: some Widget {
        CountDownWidget()
        CheckInWidget()
        // DaySnapWidgetLiveActivity()
    }
}
