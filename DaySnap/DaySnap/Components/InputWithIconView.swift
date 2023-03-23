//
//  InputWithIconView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/14.
//

import SwiftUI

struct InputWithIconView: View {
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
                .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(.white))
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color.black.opacity(0.5), lineWidth: 1)
                }
            
            Image(systemName: imageName)
                .foregroundColor(Color.black.opacity(0.85))
            
            TextField(placeholderText, text: $text)
                .textFieldStyle(.automatic)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
        .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 0)
    }
}

struct InputWithIconView_Previews: PreviewProvider {
    static var previews: some View {
        InputWithIconView(imageName: "applepencil", placeholderText: "写点有趣的", text: .constant(""), emojiText: .constant("🥳"))
    }
}
