//
//  Test1.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/24.
//

import SwiftUI

struct Test1: View {
    @State var buttons = ["Button 1", "Button 2", "Button 3"]
    @State var swipeOffset:CGFloat = 0
    @State var showDeleteButton = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center) {
                ForEach(buttons, id: \.self) { button in
                    HStack {
                        Button {
                            
                        } label: {
                            Text("\(swipeOffset)")
                                .foregroundColor(.white)
                            
                            Text(button)
                                .foregroundColor(.white)
                        }
                        .frame(width: geo.size.width, height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .offset(x: swipeOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    let width = value.translation.width
                                    
                                    guard width < 0 else { return }
                                    
                                    swipeOffset = width
                                })
                                .onEnded({ value in
                                    if value.translation.width <= -70 {
                                        swipeOffset = -70
                                    } else {
                                        swipeOffset = 0
                                    }
                                })
                        )
                        
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Circle().foregroundColor(.red))
                            .offset(x: swipeOffset)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
}

struct Test1_Previews: PreviewProvider {
    static var previews: some View {
        Test1()
    }
}
