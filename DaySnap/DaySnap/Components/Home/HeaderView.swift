//
//  HeaderView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI
import WeatherKit

struct HeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("weatherIcon") var weatherIcon: String = "icloud.slash"
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    @Binding var showAttribution: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 0) {
                    Text(getGreeting())
                    
                    if !userId.isEmpty {                        
                        HStack(spacing: 0) {
                            Text(firstName)
                            Text(lastName)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                }
                .font(.headline)
                .lineLimit(1)
                
                Text("很高兴可以再次见到你")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.6))
            }
            .padding(.vertical, 27)
            
            Spacer()
            
            Button {
                showAttribution = true
            } label: {
                Image(systemName: weatherIcon)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
            }
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
        HeaderView(showAttribution: .constant(false))
    }
}
