//
//  HeaderView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 24) {
                Text("你好，John")
                    .font(.headline)
                    .lineLimit(1)
                
                Text("很高兴可以再次见到你")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.6))
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
        .background(.white, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(color: .black.opacity(0.25), radius: 16, x: 0, y: 0)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
