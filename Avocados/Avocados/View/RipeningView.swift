//
//  RipeningView.swift
//  Avocados
//
//  Created by 沈晨凯 on 2022/11/30.
//

import SwiftUI

struct RipeningView: View {
    // MARK: - PROPERTY
    @State private var slideInAnimation: Bool = false
    var ripening: Ripening
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Image(ripening.image)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
                .background(content: {
                    Circle()
                        .fill(Color("ColorGreenLight"))
                        .frame(width: 110, height: 110, alignment: .center)
                })
                .background(content: {
                    Circle()
                        .fill(Color("ColorAppearanceAdaptive"))
                        .frame(width: 120, height: 120, alignment: .center)
                })
                .zIndex(1)
                .animation(.easeInOut(duration: 1), value: slideInAnimation)
                .offset(y: slideInAnimation ? 55 : -55)
            
            VStack(alignment: .center, spacing: 10) {
                // STAGE
                VStack(alignment: .center, spacing: 0) {
                    Text(ripening.stage)
                        .font(.system(.largeTitle, design: .serif))
                        .fontWeight(.bold)
                    
                    Text("STAGE")
                        .font(.system(.body, design: .serif))
                        .fontWeight(.heavy)
                } //: VSTACK
                .foregroundColor(Color("ColorGreenMedium"))
                .padding(.top, 65)
                .frame(width: 180)
                
                // TITLE
                Text(ripening.title)
                    .font(.system(.title, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenMedium"))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 0)
                    .frame(width: 220)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [Color.white, Color("ColorGreenLight")],
                                    startPoint: .top,
                                    endPoint: .bottom)
                            )
                            .shadow(
                                color: Color("ColorBlackTransparentLight"),
                                radius: 6, x: 0, y: 6
                            )
                    }
                
                // DESCRIPTION
                Spacer()
                Text("Fresh off the tree, the avocado is very hard with no give.")
                    .foregroundColor(Color("ColorGreenDark"))
                    .fontWeight(.bold)
                    .lineLimit(nil)
                Spacer()
                
                // RIPENESS
                Text(ripening.ripeness.uppercased())
                    .foregroundColor(.white)
                    .font(.system(.callout, design: .serif))
                    .fontWeight(.bold)
                    .shadow(radius: 3)
                    .padding(.vertical)
                    .padding(.horizontal, 0)
                    .frame(width: 185)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [Color("ColorGreenMedium"), Color("ColorGreenDark")],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .shadow(
                                color: Color("ColorBlackTransparentLight"),
                                radius: 6, x: 0, y: 6
                            )
                    }
                
                // INSTRUCTION
                Text(ripening.instruction)
                    .font(.footnote)
                    .foregroundColor(Color("ColorGreenLight"))
                    .fontWeight(.bold)
                    .lineLimit(3)
                    .frame(width: 160)
                
                Spacer()
            } //: VSTACK
            .zIndex(0)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .frame(width: 260, height: 485, alignment: .center)
            .background {
                LinearGradient(colors: [Color("ColorGreenLight"), Color("ColorGreenMedium")], startPoint: .top, endPoint: .bottom)
            }
            .cornerRadius(20)
        } //: VSTACK
        .ignoresSafeArea()
        .onAppear {
            slideInAnimation.toggle()
        }
    }
}

struct RipeningView_Previews: PreviewProvider {
    static var previews: some View {
        RipeningView(ripening: ripeningData[0])
    }
}
