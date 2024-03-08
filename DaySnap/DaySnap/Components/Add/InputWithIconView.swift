//
//  InputWithIconView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/14.
//

import SwiftUI

struct InputWithIconView: View {
    @Environment(\.colorScheme) var colorScheme
    var imageName: String
    var placeholderText: String
    @Binding var text: String
    @Binding var emojiText: String
    
    var body: some View {
        HStack(spacing: 10) {
            TextField("", text: $emojiText)
                .font(.title)
                .multilineTextAlignment(.center)
                .frame(width: 50, height: 50, alignment: .center)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .strokeStyle(cornerRadius: 8)
            
            Image(systemName: imageName)
                .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.65) : Color.black.opacity(0.85))
            
            TextField(placeholderText, text: $text)
                .textFieldStyle(.automatic)
        }
        .padding(10)
        .background(
            .ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous)
        )
        .strokeStyle(cornerRadius: 8)
        .shadow(
            color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25),
            radius: 4, x: 0, y: 2
        )
    }
}

struct InputWithIconView_Previews: PreviewProvider {
    static var previews: some View {
        InputWithIconView(imageName: "applepencil", placeholderText: "写点有趣的", text: .constant(""), emojiText: .constant("🥳"))
    }
}
