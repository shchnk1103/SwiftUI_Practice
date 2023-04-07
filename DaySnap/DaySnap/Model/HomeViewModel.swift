//
//  HomeViewModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/16.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedCountdown: CountDown?
    @Published var selectedCheckIn: CheckIn?
}
