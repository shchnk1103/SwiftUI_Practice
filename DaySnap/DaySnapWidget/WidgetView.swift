//
//  WidgetView.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/5.
//

import SwiftUI

struct WidgetView: View {
    @ObservedObject var countdownStore: CountdownStore = CountdownStore()
    var entry: Provider.Entry

    var body: some View {
        VStack {
            HStack {
                Text("\(countdownStore.countdowns.count)")
            }
        }
    }
}
