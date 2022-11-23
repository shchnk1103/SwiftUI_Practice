//
//  TouchdownApp.swift
//  Touchdown
//
//  Created by 沈晨凯 on 2022/11/18.
//

import SwiftUI

@main
struct TouchdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Shop())
        }
    }
}
