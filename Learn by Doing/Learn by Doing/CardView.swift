//
//  CardView.swift
//  Learn by Doing
//
//  Created by 沈晨凯 on 2022/11/27.
//

import SwiftUI

struct CardView: View {
    // MARK: - PROPERTY
    @State private var fadeIn: Bool = false
    @State private var moveDownward: Bool = false
    @State private var moveUpward: Bool = false
    @State private var showAlert: Bool = false
    
    var cardData: Card
    var hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Image(cardData.imageName)
                .opacity(fadeIn ? 1 : 0)
            
            VStack {
                Text(cardData.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                
                Text(cardData.headline)
                    .fontWeight(.light)
                    .italic()
            } //: VSTACK
            .foregroundColor(.white)
            .offset(y: moveDownward ? -218 : -300)
            
            Button {
                playSound(sound: "sound-chime", type: "mp3")
                hapticImpact.impactOccurred()
                showAlert.toggle()
            } label: {
                HStack {
                    Text(cardData.callToAction.uppercased())
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .accentColor(.white)
                    
                    Image(systemName: "arrow.right.circle")
                        .font(.title.weight(.medium))
                        .accentColor(.white)
                } //: HSTACK
                .padding(.vertical)
                .padding(.horizontal, 24)
                .background {
                    LinearGradient(colors: cardData.gradientColors, startPoint: .leading, endPoint: .trailing)
                }
                .clipShape(Capsule())
                .shadow(
                    color: Color("ColorShadow"), radius: 6, x: 0, y: 3
                )
            }
            .offset(y: moveUpward ? 210 : 300)
        } //: ZSTACK
        .frame(width: 335, height: 545)
        .background {
            LinearGradient(colors: cardData.gradientColors, startPoint: .top, endPoint: .bottom)
        }
        .cornerRadius(16)
        .shadow(radius: 8)
        .onAppear {
            withAnimation(.linear(duration: 1.2)) {
                fadeIn.toggle()
            }
            withAnimation(.linear(duration: 0.8)) {
                moveDownward.toggle()
                moveUpward.toggle()
            }
        } //: ONAPPEAR
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(cardData.title),
                message: Text(cardData.message),
                dismissButton: .default(Text("OK"))
            )
        } //: ALERT
    }
}

// MARK: - PREVIEW
struct CardView_Previews: PreviewProvider {
    static var card: Card = cardData[0]
    
    static var previews: some View {
        CardView(cardData: card)
    }
}
