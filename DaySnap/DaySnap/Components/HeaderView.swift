//
//  HeaderView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 24) {
                Text("你好，John")
                    .font(.headline)
                    .lineLimit(1)
                
                Text("很高兴可以再次见到你")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.6))
            }
            .padding(.vertical, 27)
            .padding(.horizontal, 32)
            
            Spacer()
            
            Image("avatar")
                .resizable()
                .frame(width: 85, height: 115)
                .scaledToFit()
                .padding(.vertical, 2)
                .padding(.trailing, 32)
        }
        .background(colorScheme == .dark ? .black : .white, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(colorScheme == .dark ? .white.opacity(0.5) : .white, lineWidth: 1)
        }
        .shadow(
            color: colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.25),
            radius: 12, x: 0, y: 0
        )
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
