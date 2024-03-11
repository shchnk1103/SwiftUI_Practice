//
//  ContentView.swift
//  TelegramDarkModeAnimation
//
//  Created by DoubleShy0N on 2023/9/28.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: Int = 0
    @State private var toggles: [Bool] = Array(repeating: false, count: 10)
    @State private var toggleDarkMode: Bool = false
    @State private var activateDarkMode: Bool = false
    @State private var buttonRect: CGRect = .zero
    /// Current & Previous State Images
    @State private var currentImage: UIImage?
    @State private var previousImage: UIImage?
    @State private var maskAnimation: Bool = false
    
    var body: some View {
        TabView(selection: $activeTab,
                content:  {
            NavigationStack {
                List {
                    Section("Text Section") {
                        Toggle("Large Display", isOn: $toggles[0])
                        Toggle("Test", isOn: $toggles[1])
                        Toggle("Play", isOn: $toggles[2])
                    }
                }
                .navigationTitle("Dark Mode")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        })
        .createImages(
            toggleDarkMode: toggleDarkMode, 
            currentImage: $currentImage,
            previousImage: $previousImage,
            activateDarkMode: $activateDarkMode
        )
        .overlay(content: {
            GeometryReader(content: { geometry in
                let size = geometry.size
                
                if let previousImage, let currentImage {
                    ZStack(content: {
                        Image(uiImage: previousImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                        
                        Image(uiImage: currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                            .mask(alignment: .topLeading) {
                                Circle()
                                    .frame(width: buttonRect.width * (maskAnimation ? 80 : 1), height: buttonRect.height * (maskAnimation ? 80 : 1), alignment: .bottomLeading)
                                    .frame(width: buttonRect.width, height: buttonRect.height)
                                    .offset(x: buttonRect.minX, y: buttonRect.minY)
                                    .ignoresSafeArea()
                            }
                    })
                    .task {
                        guard !maskAnimation else { return }
                        
                        withAnimation(
                            .easeInOut(duration: 0.9),
                            completionCriteria: .logicallyComplete)
                        {
                             maskAnimation = true
                        } completion: {
                            /// Removing all snapshots
                            self.currentImage = nil
                            self.previousImage = nil
                            maskAnimation = false
                        }

                    }
                }
            })
            /// Reverse Masking
            .mask({
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        Circle()
                            .frame(width: buttonRect.width, height: buttonRect.height)
                            .offset(x: buttonRect.minX, y: buttonRect.minY)
                            .blendMode(.destinationOut)
                    }
            })
            .ignoresSafeArea()
        })
        .overlay(alignment: .topTrailing) {
            Button(action: {
                toggleDarkMode.toggle()
            }, label: {
                Image(systemName: toggleDarkMode ? "sun.max.fill" : "moon.fill")
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .symbolEffect(.bounce, value: toggleDarkMode)
                    .frame(width: 40, height: 40)
            })
            .rect { rect in
                buttonRect = rect
            }
            .padding(10)
            .disabled(currentImage != nil || previousImage != nil || maskAnimation)
        }
        .preferredColorScheme(activateDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
