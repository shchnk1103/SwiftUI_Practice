//
//  HomeViewModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/16.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedData: Checkin?
    @Published var headerHeight: CGFloat = 0

    var selectedCheckin: Binding<Checkin?> {
        Binding<Checkin?>(
            get: { self.selectedData },
            set: { self.selectedData = $0 }
        )
    }
    
    func setHeaderHeight(_ height: CGFloat) {
        headerHeight = height
    }
}
