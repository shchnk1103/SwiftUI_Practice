//
//  GalleryView.swift
//  Africa
//
//  Created by 沈晨凯 on 2022/11/11.
//

import SwiftUI

struct GalleryView: View {
    let animals: [Animal] = Bundle.main.decode("animals.json")
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    @State private var selectedAnimal: String = "lion"
    
    //    let gridLayout: [GridItem] = [
    //        GridItem(.flexible()),
    //        GridItem(.flexible()),
    //        GridItem(.flexible())
    //    ]
    
    //    let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 3.0
    
    func gridSwitch() {
        gridLayout = Array(
            repeating: .init(.flexible()),
            count: Int(gridColumn)
        )
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .center, spacing: 30) {
                Image(selectedAnimal)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 8)
                    }
                
                Slider(value: $gridColumn, in: 2...4, step: 1)
                    .padding(.horizontal)
                    .onChange(of: gridColumn) { newValue in
                        withAnimation(.easeIn) {
                            gridSwitch()
                        }
                    }
                
                LazyVGrid(
                    columns: gridLayout,
                    alignment: .center,
                    spacing: 10
                ) {
                    ForEach(animals) { animal in
                        Image(animal.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(.white, lineWidth: 1)
                            }
                            .onTapGesture {
                                selectedAnimal = animal.image
                                haptics.impactOccurred()
                            }
                    } //: LOOP
                } //: GRID
                .onAppear {
                    withAnimation(.easeIn) {
                        gridSwitch()
                    }
                }
            } //: VSTACK
            .padding(.horizontal, 10)
            .padding(.vertical, 50)
        }) //: SCROLL
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            MotionAnimationView()
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
