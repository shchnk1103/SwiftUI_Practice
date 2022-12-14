//
//  Model.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/5.
//

import SwiftUI
import Combine

class Model: ObservableObject {
    @Published var showDetail: Bool = false
    @Published var selectedModal: Modal = .signIn
}

enum Modal: String {
    case signUp
    case signIn
}
