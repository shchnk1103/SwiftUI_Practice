//
//  HomeView.swift
//  SheetAnimation
//
//  Created by DoubleShy0N on 2023/10/13.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedProfile: Profile?
    @State private var showProfileView: Bool = false
    @Environment(WindowSharedModel.self) private var windowSharedModel
    @Environment(SceneDelegate.self) private var scenceDelegate
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15, content: {
                ForEach(profiles) { profile in
                    HStack(spacing: 12, content: {
                        Image(profile.profilePicture)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .contentShape(Circle())
                            .onTapGesture {
                                selectedProfile = profile
                                showProfileView.toggle()
                            }
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text(profile.username)
                                .fontWeight(.bold)
                            
                            Text(profile.lastMsg)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(profile.lastActive)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    })
                }
            })
            .padding(12)
            .padding(.horizontal, 5)
        }
        .scrollIndicators(.hidden)
        .sheet(isPresented: $showProfileView, content: {
            DetailProfileView(
                selectedProfile: $selectedProfile,
                showProfileView: $showProfileView
            )
            .presentationDetents([.medium, .large])
            .presentationCornerRadius(25)
            .interactiveDismissDisabled()
        })
        .onAppear(perform: {
            guard scenceDelegate.heroWindow == nil else { return }
            scenceDelegate.addHeroWindow(WindowSharedModel)
        })
    }
}

struct DetailProfileView: View {
    @Binding var selectedProfile: Profile?
    @Binding var showProfileView: Bool
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        VStack(content: {
            GeometryReader(content: { geometry in
                let size = geometry.size
                
                if let selectedProfile {
                    Image(selectedProfile.profilePicture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .overlay {
                            let color = scheme == .dark ? Color.black : Color.white
                            LinearGradient(
                                colors: [
                                    .clear,
                                    .clear,
                                    .clear,
                                    color.opacity(0.1),
                                    color.opacity(0.5),
                                    color.opacity(0.9),
                                    color
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                        .clipped()
                }
            })
            .frame(maxHeight: 330)
            .overlay(alignment: .topLeading) {
                Button(action: {
                    showProfileView = false
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .contentShape(.rect)
                        .padding(10)
                        .background(.black, in: .circle)
                })
                .padding([.top, .leading], 20)
                .scaleEffect(0.9)
            }
            
            Spacer()
        })
    }
}

#Preview {
    ContentView()
}
