//
//  WarnView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/15.
//

import SwiftUI

struct WarnView: View {
    @Binding var flag: Bool
    @State private var appear: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.15)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    Spacer()
                    
                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 80))
                    
                    Spacer()
                    
                    Text("请您填写完整！")
                    
                    Spacer()
                }
                .frame(width: geo.size.width / 2, height: geo.size.width / 2)
                .background(.regularMaterial)
                .cornerRadius(12)
                .opacity(appear ? 1 : 0.5)
                .position(x: geo.size.width / 2, y: appear ? geo.size.height / 2 : geo.size.height / 2 + 100)
            }
        }
        .onAppear(perform: {
            withAnimation(.default.delay(0.2)) {
                appear = true
            }
        })
        .onTapGesture {
            flag.toggle()
        }
    }
}

struct WarnView_Previews: PreviewProvider {
    static var previews: some View {
        WarnView(flag: .constant(false))
    }
}
