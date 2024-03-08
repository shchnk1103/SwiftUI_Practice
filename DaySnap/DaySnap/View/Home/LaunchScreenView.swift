//
//  LaunchScreenView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/11.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                Text("DaySnap")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 0.6)) {
                    size = 1.0
                    opacity = 1.0
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
