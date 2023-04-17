//
//  CheckInFilter.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/16.
//

import Foundation
import Combine

class CheckInFilter: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var status: String = "" {
        didSet {
            objectWillChange.send()
        }
    }

    init(_ status: String = "") {
        self.status = status
    }
}
