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
    // 自定义颜色
    @AppStorage("colorCustom") var colorCustom: String = ""
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            Button {
                configuration.isOn.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(
                        configuration.isOn
                        ? (colorSchceme == .dark
                           ? (colorCustom == ""
                              ? .black
                              : stringToColor(color: colorCustom).opacity(0.6))
                           : (colorCustom == ""
                              ? .gray
                              : stringToColor(color: colorCustom).opacity(0.6)))
                        : (colorSchceme == .dark
                           ? .gray
                           : .white)
                    )
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
                                .fill(
                                    colorSchceme == .dark
                                    ? (colorCustom == ""
                                       ? .white
                                       : stringToColor(color: colorCustom).opacity(0.8))
                                    : (colorCustom == ""
                                       ? .black
                                       : stringToColor(color: colorCustom))
                                )
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

struct ButtonBackgroundColorModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    // 自定义颜色
    @AppStorage("colorCustom") var colorCustom: String = ""
    // 自定义按钮颜色
    @AppStorage("colorButton") var colorButton: String = ""
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(
                colorScheme == .dark
                ? (colorButton == ""
                   ? (colorCustom == ""
                      ? .white.opacity(0.8)
                      : stringToColor(color: colorCustom))
                   : stringToColor(color: colorButton))
                : (colorButton == ""
                   ? (colorCustom == ""
                      ? .black
                      : stringToColor(color: colorCustom))
                   : stringToColor(color: colorButton))
            )
    }
}

extension View {
    func buttonBackgroundColor() -> some View {
        self.modifier(ButtonBackgroundColorModifier())
    }
}
