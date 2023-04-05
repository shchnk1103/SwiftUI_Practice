//
//  Provider.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/5.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: .now)
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = SimpleEntry(date: .now)
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        
        completion(timeline)
    }
}
