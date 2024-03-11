//
//  ContentView.swift
//  CustomLockScreen
//
//  Created by DoubleShy0N on 2023/10/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LockView(lockType: .both, lockPin: "1234", isEnabled: true) {
            VStack(spacing: 15, content: {
                Image(systemName: "globe")
                    .imageScale(.large)
                
                Text("Hello World!")
            })
        }
    }
}

#Preview {
    ContentView()
}
