//
//  CheckInWidgetProvider.swift
//  DaySnapWidgetExtension
//
//  Created by DoubleShy0N on 2023/4/19.
//

import SwiftUI
import WidgetKit
import CoreData

struct CheckInWidgetProvider: TimelineProvider {
    typealias Entry = CheckInWidgetEntry
    
    let dataController: DataController
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func placeholder(in context: Context) -> CheckInWidgetEntry {
        CheckInWidgetEntry(date: Date(), checkins: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (CheckInWidgetEntry) -> ()) {
        let entry = CheckInWidgetEntry(date: Date(), checkins: [])
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CheckInWidgetEntry>) -> ()) {
        let request: NSFetchRequest<CheckIn> = CheckIn.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \CheckIn.isCheckin, ascending: true),
        ]
        
        do {
//            let checkins = try dataController.context.fetch(request)
//            let entry = CheckInWidgetEntry(date: Date(), checkins: checkins)
//            let timeline = Timeline(entries: [entry], policy: .atEnd)
//            completion(timeline)
        } catch {
            let entry = CheckInWidgetEntry(date: Date(), checkins: [])
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}
