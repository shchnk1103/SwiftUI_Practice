//
//  NumberOnlyTextField.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/14.
//

import SwiftUI
import Combine

struct NumberOnlyTextField: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var persistDate: String
    
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(.secondary)
            
            TextField("准备坚持几天", text: $persistDate)
                .keyboardType(.numberPad)
                .onReceive(Just(persistDate), perform: { newValue in
                    let filtered = newValue.filter {
                        "0123456789".contains($0)
                    }
                    persistDate = filtered != newValue ? filtered : persistDate
                })
                .onChange(of: persistDate, perform: { newValue in
                    persistDate = newValue == "" ? "" : "准备坚持\(newValue)天"
                })
                .textFieldStyle(.automatic)
        }
        .padding(10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .strokeStyle(cornerRadius: 8)
        .shadow(color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), radius: 8, x: 0, y: 6)
    }
}

struct NumberOnlyTextField_Previews: PreviewProvider {
    static var previews: some View {
        NumberOnlyTextField(persistDate: .constant(""))
    }
}
