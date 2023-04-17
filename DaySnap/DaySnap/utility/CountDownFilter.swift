//
//  CountDownFilter.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/14.
//

import Foundation
import Combine

class CountDownFilter: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var category: String = "" {
        didSet {
            objectWillChange.send()
        }
    }

    init(_ category: String = "") {
        self.category = category
    }
}
