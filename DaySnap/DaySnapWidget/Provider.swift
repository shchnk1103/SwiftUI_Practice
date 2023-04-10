//
//  Provider.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/5.
//

import SwiftUI
import WidgetKit
import CoreData

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    let dataController: DataController
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), countdowns: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), countdowns: [])
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let request: NSFetchRequest<CountDown> = CountDown.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "isPinned", ascending: true)]
        
        do {
            let countdowns = try dataController.context.fetch(request)
            let entry = SimpleEntry(date: Date(), countdowns: countdowns)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        } catch {
            let entry = SimpleEntry(date: Date(), countdowns: [])
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}
