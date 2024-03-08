//
//  DetailView.swift
//  NavigationStackAnimation
//
//  Created by DoubleShy0N on 2023/7/24.
//

import SwiftUI

struct DetailView: View {
    /// View Properties
    @Binding var selectedProfile: Profile?
    @Binding var pushView: Bool
    @Binding var hideView: (Bool, Bool)
    
    var body: some View {
        if let selectedProfile {
            VStack {
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    
                    VStack {
                        if hideView.0 {
                            ImageView(profile: selectedProfile, size: size)
                                /// Custom Close Button
                                .overlay(alignment: .top) {
                                    ZStack(content: {
                                        Button(action: {
                                            /// Closing the View with animation
                                            hideView.0 = false
                                            hideView.1 = false
                                            pushView = false
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                                self.selectedProfile = nil
                                            }
                                        }, label: {
                                            Image(systemName: "xmark")
                                                .foregroundStyle(.white)
                                                .padding(10)
                                                .background(.black, in: .circle)
                                                .contentShape(.circle)
                                        })
                                        .padding(15)
                                        .padding(.top, 40)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        
                                        Text(selectedProfile.userName)
                                            .font(.title.bold())
                                            .foregroundStyle(.black)
                                            .padding(15)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                    })
                                    .opacity(hideView.1 ? 1 : 0)
                                    .animation(.snappy, value: hideView.1)
                                }
                                .onAppear(perform: {
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        hideView.1 = true
                                    }
                                })
                        } else {
                            Color.clear
                        }
                    }
                    /// Destination View Anchor
                    .anchorPreference(key: MAnchorKey.self, value: .bounds, transform: { anchor in
                        return [selectedProfile.id: anchor]
                    })
                })
                .frame(height: 400)
                .ignoresSafeArea()
                
                Spacer(minLength: 0)
            }
            .toolbar(hideView.0 ? .hidden : .visible, for: .navigationBar)
            .onAppear(perform: {
                /// Removing the Animated View once the Animation is Finished
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    hideView.0 = true
                }
            })
        }
    }
}

#Preview {
    DetailView(selectedProfile: .constant(profiles[0]), pushView: .constant(true), hideView: .constant((true, true)))
}
