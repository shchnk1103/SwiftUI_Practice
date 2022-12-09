//
//  EmptyListView.swift
//  Todo
//
//  Created by DoubleShy0N on 2022/12/9.
//

import SwiftUI

struct EmptyListView: View {
    // MARK: - PROPERTY
    @State private var isAnimated: Bool = false
    
    let images: [String] = [
        "illustration-no1",
        "illustration-no2",
        "illustration-no3"
    ]
    
    let tips: [String] = [
        "Use your time wisely.",
        "Slow and steady wins the race.",
        "Keep it short and sweet.",
        "Put hard tasks first",
        "Reward yourself ahead of time.",
        "Each night schedule for tomorrow."
    ]
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image("\(images.randomElement() ?? images[0])")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                
                Text("\(tips.randomElement() ?? tips[0])")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            } //: VSTACK
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1.5), value: isAnimated)
            .onAppear {
                isAnimated.toggle()
            }
        } //: ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background {
            Color("ColorBase")
        }
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
