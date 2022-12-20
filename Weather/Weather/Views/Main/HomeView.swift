//
//  HomeView.swift
//  Weather
//
//  Created by DoubleShy0N on 2022/12/18.
//

import SwiftUI
import BottomSheet

enum BottomShapePosition: CGFloat, CaseIterable {
    case top = 0.83
    case middle = 0.385
}

struct HomeView: View {
    @State var bottomShapePosition: BottomShapePosition = .middle
    @State var bottomShapeTranslation: CGFloat = BottomShapePosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    var bottomShapeTranslationProrated: CGFloat {
        (bottomShapeTranslation - BottomShapePosition.middle.rawValue) / (BottomShapePosition.top.rawValue - BottomShapePosition.middle.rawValue)
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let height = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = height + 36
                
                ZStack {
                    // MARK: - Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: - Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomShapeTranslationProrated * imageOffset)
                    
                    // MARK: - House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomShapeTranslationProrated * imageOffset)
                    
                    VStack(spacing: -10 * (1 - bottomShapeTranslationProrated)) {
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                            
                            Text("H:24°   L:18°")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .opacity(1 - bottomShapeTranslationProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomShapeTranslationProrated * 46)
                    
                    // MARK: - Bottom Sheet
                    BottomSheetView(position: $bottomShapePosition) {
                        //Text(bottomShapeTranslationProrated.formatted())
                    } content: {
                        ForecastView(bottomShapeTranslationProrated: bottomShapeTranslationProrated)
                    }
                    .onBottomSheetDrag { translation in
                        bottomShapeTranslation = translation / height
                        
                        withAnimation(.easeInOut) {
                            if bottomShapePosition == BottomShapePosition.top {
                                hasDragged = true
                            } else {
                                hasDragged = false
                            }
                        }
                    }
                    
                    // MARK: - Tab Bar
                    TabBar(action: {
                        if bottomShapePosition == .middle {
                            bottomShapePosition = .top
                        } else {
                            bottomShapePosition = .middle
                        }
                    })
                    .offset(y: bottomShapeTranslationProrated * 115)
                }
                .toolbar(.hidden)
            }
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + (hasDragged ? " | " : "\n ") + "Mostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96 - bottomShapeTranslationProrated * 76, weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomShapeTranslationProrated)
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
