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

struct StrokeStyle: ViewModifier {
    
    var cornerRadius: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content.overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.1 : 0.3),
                            .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .blendMode(.overlay)
        }
    }
}

extension View {
    func strokeStyle(cornerRadius: CGFloat = 8) -> some View {
        modifier(StrokeStyle(cornerRadius: cornerRadius))
    }
}
