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
                Text(getGreeting())
                    .font(.headline)
                    .lineLimit(1)
                
                Text("很高兴可以再次见到你")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.6))
            }
            .padding(.vertical, 27)
            
            Spacer()
            
            Image("avatar")
                .resizable()
                .frame(width: 85, height: 115)
                .scaledToFit()
                .padding(.vertical, 2)
        }
    }
    
    func getGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let greeting: String
        
        if hour < 12 {
            greeting = "上午好！"
        } else if hour < 18 {
            greeting = "下午好！"
        } else {
            greeting = "晚上好！"
        }
        
        return greeting
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
