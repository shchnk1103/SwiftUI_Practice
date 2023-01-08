//
//  Styles.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/3.
//

import SwiftUI

struct StrokeModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(content: {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(
                        .linearGradient(
                            colors: [
                                .white.opacity(colorScheme == .dark ? 0.1 : 0.3),
                                .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                            ],
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                    .blendMode(.overlay)
            })
    }
}

extension View {
    func strokeStyle(cornerRadius: CGFloat = 30) -> some View {
        modifier(StrokeModifier(cornerRadius: cornerRadius))
    }
}
