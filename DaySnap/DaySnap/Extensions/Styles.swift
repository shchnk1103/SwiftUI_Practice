//
//  Styles.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/12.
//

import Foundation
import SwiftUI

struct CustomTopToggleStyle: ToggleStyle {
    @Environment(\.colorScheme) var colorSchceme
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Button {
                configuration.isOn.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(configuration.isOn ? (colorSchceme == .dark ? .black : .gray) : (colorSchceme == .dark ? .gray : .white))
                    .frame(width: 32, height: 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(colorSchceme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), lineWidth: 1)
                    )
                    .overlay(
                        HStack {
                            if configuration.isOn {
                                Spacer()
                            }
                            Circle()
                                .fill(colorSchceme == .dark ? .white : .black)
                            if !configuration.isOn {
                                Spacer()
                            }
                        }
                            .animation(.default, value: configuration.isOn)
                    )
                    .padding(2)
            }
        }
    }
}
