//
//  AvocadosView.swift
//  Avocados
//
//  Created by 沈晨凯 on 2022/11/29.
//

import SwiftUI

struct AvocadosView: View {
    // MARK: - PROPERTY
    @State private var pulsateAnimation: Bool = false
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            
            Image("avocado")
                .resizable()
                .scaledToFit()
                .frame(width: 240, height: 240, alignment: .center)
                .shadow(color: Color("ColorBlackTransparentDark"), radius: 12, x: 0, y: 8)
                .scaleEffect(pulsateAnimation ? 1 : 0.9)
                .opacity(pulsateAnimation ? 1 : 0.9)
                .animation(
                    .easeOut(duration: 1.5).repeatForever(autoreverses: true),
                    value: pulsateAnimation
                )
            
            VStack {
                Text("Avocados".uppercased())
                    .font(.system(size: 42, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                    .padding()
                    .shadow(color: Color("ColorBlackTransparentDark"), radius: 4, x: 0, y: 4)
                Text("Creamy, green, and full of nutrients! Avocado is a powerhouse ingredient at any meal. Enjoy these handpicked avocado recipes for breakfast, lunch, dinner & more!")
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .foregroundColor(Color("ColorGreenLight"))
                    .font(.system(.headline, design: .serif))
                    .frame(maxWidth: 640, minHeight: 120)
            } //: VSTACK
            .padding()
            
            Spacer()
        } //: VSTACK
        .background {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .ignoresSafeArea()
        .onAppear {
            pulsateAnimation.toggle()
        }
    }
}

struct AvocadosView_Previews: PreviewProvider {
    static var previews: some View {
        AvocadosView()
    }
}
