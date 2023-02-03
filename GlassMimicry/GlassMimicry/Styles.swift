//
//  Styles.swift
//  GlassMimicry
//
//  Created by DoubleShy0N on 2023/1/13.
//

import SwiftUI

struct BoxShadowModifier: ViewModifier {
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(Color.white.opacity(0.5))
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(
                        .linearGradient(
                            colors: [.white.opacity(0.8), .white.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: .gray.opacity(0.15), radius: 15, x: 0, y: 2)
    }
}

extension View {
    func boxShadowStyle(cornerRadius: CGFloat = 8) -> some View {
        modifier(BoxShadowModifier(cornerRadius: cornerRadius))
    }
}
